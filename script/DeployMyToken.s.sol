// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../src/MyToken.sol";

contract DeployMyToken is Script {
    function run() external {
        vm.startBroadcast();
        MyToken token = new MyToken();
        token.initialize("MyToken", "MYT", msg.sender); // 배포자 주소를 owner로
        vm.stopBroadcast();
    }
}
