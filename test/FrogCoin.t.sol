// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/FrogCoin.sol";

contract FrogCoinTest is Test {
    FrogCoin public frogCoin;
    address public owner;
    address public user1;
    address public user2;

    function setUp() public {
        owner = makeAddr("owner");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        vm.prank(owner);
        frogCoin = new FrogCoin();
    }

    function test_InitialSupplyAndDetails() public {
        assertEq(frogCoin.name(), "FrogCoin");
        assertEq(frogCoin.symbol(), "FROG");
        assertEq(frogCoin.totalSupply(), 0);
        assertEq(frogCoin.decimals(), 18);
    }

    function test_Mint_Success() public {
        uint256 mintAmount = 1000 ether;

        vm.prank(owner);
        frogCoin.mint(user1, mintAmount);

        assertEq(frogCoin.balanceOf(user1), mintAmount);
        assertEq(frogCoin.totalSupply(), mintAmount);
    }

    function test_Mint_RevertWhenNotOwner() public {
        vm.prank(user1);
        vm.expectRevert("Ownable: caller is not the owner");
        frogCoin.mint(user1, 100 ether);
    }

    function test_Burn_Success() public {
        uint256 mintAmount = 1000 ether;

        vm.prank(owner);
        frogCoin.mint(user1, mintAmount);

        vm.prank(owner);
        frogCoin.burn(user1, 200 ether);

        assertEq(frogCoin.balanceOf(user1), 800 ether);
        assertEq(frogCoin.totalSupply(), 800 ether);
    }

    function test_Burn_RevertWhenNotOwner() public {
        vm.prank(user1);
        vm.expectRevert("Ownable: caller is not the owner");
        frogCoin.burn(user1, 100 ether);
    }

    function test_Burn_RevertInsufficientBalance() public {
        vm.prank(owner);
        frogCoin.mint(user1, 100 ether);

        vm.prank(owner);
        vm.expectRevert("ERC20: burn amount exceeds balance");
        frogCoin.burn(user1, 200 ether);
    }

    function test_Transfer_Success() public {
        uint256 mintAmount = 500 ether;

        vm.prank(owner);
        frogCoin.mint(owner, mintAmount);

        vm.prank(owner);
        frogCoin.transfer(user1, 200 ether);

        assertEq(frogCoin.balanceOf(user1), 200 ether);
        assertEq(frogCoin.balanceOf(owner), 300 ether);
    }
}
