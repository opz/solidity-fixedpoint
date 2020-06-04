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

// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity >=0.4.0;

import {Babylonian} from "./Babylonian.sol";

library FixedPoint {
    // range: [0, 2**128 - 1]
    // resolution: 1 / 2**128
    struct uq128x128 { // solhint-disable-line contract-name-camelcase
        uint _x;
    }

    uint8 private constant _RESOLUTION = 128;
    uint private constant _Q128 = uint(1) << _RESOLUTION;
    uint private constant _Q256 = _Q128 << _RESOLUTION;

    // encode a uint128 as a UQ128x128
    function encode(uint128 x) internal pure returns (uq128x128 memory) {
        return uq128x128(uint(x) << _RESOLUTION);
    }

    // divide a UQ128x128 by a uint128, returning a UQ128x128
    function div(uq128x128 memory self, uint128 x) internal pure returns (uq128x128 memory) {
        require(x != 0, "FixedPoint: DIV_BY_ZERO");
        return uq128x128(self._x / uint(x));
    }

    // multiply a UQ128x128 by a uint, returning a UQ128x128
    // reverts on overflow
    function mul(uq128x128 memory self, uint y) internal pure returns (uq128x128 memory) {
        uint z;
        require(
            y == 0 || (z = self._x * y) / y == self._x,
            "FixedPoint: MUL_OVERFLOW"
        );
        return uq128x128(z);
    }

    // returns a UQ128x128 which represents the ratio of the numerator to the denominator
    // equivalent to encode(numerator).div(denominator)
    function fraction(uint128 numerator, uint128 denominator)
        internal
        pure
        returns (uq128x128 memory)
    {
        require(denominator > 0, "FixedPoint: DIV_BY_ZERO");
        return uq128x128((uint(numerator) << _RESOLUTION) / denominator);
    }

    // decode a UQ128x128 into a uint128 by truncating after the radix point
    function decode(uq128x128 memory self) internal pure returns (uint128) {
        return uint128(self._x >> _RESOLUTION);
    }

    // take the reciprocal of a UQ128x128
    function reciprocal(uq128x128 memory self) internal pure returns (uq128x128 memory) {
        require(self._x != 0, "FixedPoint: ZERO_RECIPROCAL");
        return uq128x128(_Q128 / self._x * _Q128);
    }

    // square root of a UQ128x128
    function sqrt(uq128x128 memory self) internal pure returns (uq128x128 memory) {
        return uq128x128(Babylonian.sqrt(self._x) << 64);
    }
}
