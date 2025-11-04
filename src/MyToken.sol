// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// OpenZeppelin 라이브러리에서 ERC-20 표준 코드를 가져옵니다.
import "openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";

/**
 * @title MyToken
 * @dev 업그레이드 가능한 ERC-20 토큰의 기본 형태입니다.
 * - Ownable: 관리자(Owner)만 민감한 함수를 호출할 수 있게 합니다.
 */
contract MyToken is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    
    /**
     * @dev 컨트랙트가 처음 배포될 때 단 한 번만 호출되는 "생성자" 역할의 함수입니다.
     * @param _name 토큰 이름 (예: "아이피스 조각")
     * @param _symbol 토큰 심볼 (예: "IPC")
     * @param _initialOwner 컨트랙트의 관리자 주소
     */
    function initialize(
        string memory _name,
        string memory _symbol,
        address _initialOwner
    ) public initializer {
        // 부모 컨트랙트들을 초기화합니다.
        __ERC20_init(_name, _symbol);
        __Ownable_init(_initialOwner);
    }

    /**
     * @dev 관리자(Owner)만 이 함수를 호출하여 토큰을 "발행"할 수 있습니다.
     * @param to 토큰을 받을 주소
     * @param amount 발행할 수량
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
