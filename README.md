# Solidity Fixed Point Library

[![Actions Status](https://github.com/opz/solidity-fixedpoint/workflows/CI/badge.svg)](https://github.com/opz/solidity-fixedpoint/actions)
[![npm](https://img.shields.io/npm/v/solidity-fixedpoint)](https://unpkg.com/solidity-fixedpoint@latest/)

Implements fixed point numbers in Solidity using the [Q number format](https://en.wikipedia.org/wiki/Q_(number_format)).

Built off the Uniswap [FixedPoint](https://github.com/Uniswap/uniswap-lib/blob/master/contracts/libraries/FixedPoint.sol) and [Babylonian](https://github.com/Uniswap/uniswap-lib/blob/master/contracts/libraries/Babylonian.sol) libraries developed by [moodysalem](https://github.com/moodysalem).

This library maximizes both range and resolution of fixed point numbers by increasing the size of the Q format from UQ112x112 to UQ128x128. Uniswap originally used UQ112x112 to optimize the variable packing in their contracts.

## Install Dependencies

`npm install`

## Compile Contracts

`npx buidler compile`

## Run Tests

`npx buidler test`

## Contributors

* [@opz](https://github.com/opz) 💻
