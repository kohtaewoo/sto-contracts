// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/MyToken.sol";
import "openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";

contract MyTokenTest is Test {
    MyToken public token;
    address public owner = address(0x1);
    address public user = address(0x2);

    function setUp() public {
        token = new MyToken();
        token.initialize("MyToken", "MYT", owner);
    }

    function test_Initialization() public view {
        assertEq(token.name(), "MyToken", "Name should be MyToken");
        assertEq(token.symbol(), "MYT", "Symbol should be MYT");
        assertEq(token.owner(), owner, "Owner should be set");
    }

    function test_Minting() public {
        vm.prank(owner);
        token.mint(user, 100 ether);
        assertEq(token.balanceOf(user), 100 ether, "Minted balance mismatch");
    }

    // 권한 없는 계정이 mint 시도 → OZ의 OwnableUnauthorizedAccount 에러를 정확히 기대
    function test_Fail_MintingByNonOwner() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUpgradeable.OwnableUnauthorizedAccount.selector, user));
        vm.prank(user);
        token.mint(user, 100 ether);
    }
}
