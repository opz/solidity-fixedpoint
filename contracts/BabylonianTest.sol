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

contract BabylonianTest {
    function sqrt(uint num) public pure returns (uint)  {
        return Babylonian.sqrt(num);
    }
}
