// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Ownable } from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import { ERC20 } from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract FrogCoin is ERC20, Ownable {
    constructor() ERC20("FrogCoin", "FROG") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyOwner {
        _burn(from, amount);
    }
}
