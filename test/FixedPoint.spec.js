/**
 * Copyright (C) 2020  moodysalem
 * Modifications Copyright (C) 2020  Will Shahda
 * 2020-06-03: Update for use as a general purpose library
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

const { expect } = require("chai");
const { deployContract } = require("ethereum-waffle");
const { bigNumberify } = require("ethers/utils");

const FixedPoint = require("../artifacts/FixedPointTest.json");

const Q128 = bigNumberify(2).pow(128);

describe("FixedPoint", () => {
  const provider = waffle.provider;
  const [wallet] = provider.getWallets();

  let fixedPoint;

  before(async () => {
    fixedPoint = await deployContract(wallet, FixedPoint);
  });

  describe("encode", () => {
    it("shifts left by 128", async () => {
      expect((await fixedPoint.encode("0x01"))[0]).to.eq(Q128.toHexString())
    });

    it("will not take >uint128(-1)", async () => {
      expect(() => fixedPoint.encode(bigNumberify(2).pow(129).sub(1))).to.throw
    });
  });

  describe("decode", () => {
    it("shifts right by 128", async () => {
      expect(await fixedPoint.decode([bigNumberify(3).mul(Q128)])).to.eq(bigNumberify(3))
    });

    it("will not take >uint256(-1)", async () => {
      expect(() => fixedPoint.decode([bigNumberify(2).pow(256).sub(1)])).to.throw
    });
  });

  describe("div", () => {
    it("correct division", async () => {
      expect((await fixedPoint.div([bigNumberify(3).mul(Q128)], bigNumberify(2)))[0]).to.eq(
        bigNumberify(3).mul(Q128).div(2)
      );
    });

    it("throws for div by zero", async () => {
      await expect(fixedPoint.div([bigNumberify(3).mul(Q128)], 0)).to.be.revertedWith("FixedPoint: DIV_BY_ZERO");
    });
  });

  describe("mul", () => {
    it("correct multiplication", async () => {
      expect((await fixedPoint.mul([bigNumberify(3).mul(Q128)], bigNumberify(2)))[0]).to.eq(
        bigNumberify(3).mul(2).mul(Q128)
      );
    });

    it("overflow", async () => {
      await expect(fixedPoint.mul([bigNumberify(1).mul(Q128)], bigNumberify(2).pow(128))).to.be.revertedWith(
        "FixedPoint: MUL_OVERFLOW"
      );
    });
  });

  describe("fraction", () => {
    it("correct computation less than 1", async () => {
      expect((await fixedPoint.fraction(4, 100))[0]).to.eq(bigNumberify(4).mul(Q128).div(100));
    });

    it("correct computation greater than 1", async () => {
      expect((await fixedPoint.fraction(100, 4))[0]).to.eq(bigNumberify(100).mul(Q128).div(4));
    });

    it("fails with 0 denominator", async () => {
      await expect(fixedPoint.fraction(bigNumberify(1), bigNumberify(0))).to.be.revertedWith("FixedPoint: DIV_BY_ZERO");
    });
  });

  describe("reciprocal", () => {
    it("works for 0.25", async () => {
      expect((await fixedPoint.reciprocal([Q128.mul(bigNumberify(25)).div(100)]))[0]).to.eq(Q128.mul(4));
    });

    it("fails for 0", async () => {
      await expect(fixedPoint.reciprocal([bigNumberify(0)])).to.be.revertedWith("FixedPoint: ZERO_RECIPROCAL");
    });
  })

  describe("sqrt", () => {
    it("works for 25", async () => {
      expect((await fixedPoint.sqrt([bigNumberify(25).mul(Q128)]))[0]).to.eq(bigNumberify(5).mul(Q128));
    });

    it("works with numbers less than 1", async () => {
      expect((await fixedPoint.sqrt([bigNumberify(1225).mul(Q128).div(100)]))[0]).to.eq(
        bigNumberify(35).mul(Q128).div(10)
      );
    });
  });
});
