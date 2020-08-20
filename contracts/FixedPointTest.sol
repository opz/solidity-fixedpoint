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
pragma experimental ABIEncoderV2;

import {FixedPoint} from "./FixedPoint.sol";

contract FixedPointTest {
    function encode(uint192 x) external pure returns (FixedPoint.uq192x64 memory) {
        return FixedPoint.encode(x);
    }

    // divide a UQ192x64 by a uint192, returning a UQ192x64
    function div(FixedPoint.uq192x64 calldata self, uint192 y)
        external
        pure
        returns (FixedPoint.uq192x64 memory)
    {
        return FixedPoint.div(self, y);
    }

    function fraction(uint192 numerator, uint192 denominator)
        external
        pure
        returns (FixedPoint.uq192x64 memory)
    {
        return FixedPoint.fraction(numerator, denominator);
    }

    // multiply a UQ192x64 by a uint, returning a UQ192x64
    function mul(FixedPoint.uq192x64 calldata self, uint y)
        external
        pure
        returns (FixedPoint.uq192x64 memory)
    {
        return FixedPoint.mul(self, y);
    }

    // decode a UQ192x64 in a uint container into a uint by truncating after the radix point
    function decode(FixedPoint.uq192x64 calldata self) external pure returns (uint192) {
        return FixedPoint.decode(self);
    }

    function reciprocal(FixedPoint.uq192x64 calldata self)
        external
        pure
        returns (FixedPoint.uq192x64 memory)
    {
        return FixedPoint.reciprocal(self);
    }

    function sqrt(FixedPoint.uq192x64 calldata self)
        external
        pure
        returns (FixedPoint.uq192x64 memory)
    {
        return FixedPoint.sqrt(self);
    }
}
