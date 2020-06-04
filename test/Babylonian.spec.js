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
const { MaxUint256 } = require("ethers/constants");

const Babylonian = require("../artifacts/BabylonianTest.json");

describe("Babylonian", () => {
  const provider = waffle.provider;
  const [wallet] = provider.getWallets();

  let babylonian;

  before(async () => {
    babylonian = await deployContract(wallet, Babylonian);
  });

  describe('sqrt', () => {
    it('works for 0-99', async () => {
      for (let i = 0; i < 100; i++) {
        expect(await babylonian.sqrt(i)).to.eq(Math.floor(Math.sqrt(i)));
      }
    });

    it('max uint256', async () => {
      const expected = bigNumberify(2).pow(128).sub(1);
      expect(await babylonian.sqrt(MaxUint256)).to.eq(expected);
    });
  });
});
