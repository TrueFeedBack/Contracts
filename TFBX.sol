// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// www.truefeedback.io
// TFBX Token
// @2021

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20CappedUpgradeable.sol";

contract TFBX is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, OwnableUpgradeable, UUPSUpgradeable, ERC20CappedUpgradeable {
    function initialize() initializer public {
        __ERC20_init("Truefeedback Token", "TFBX");
        __ERC20Burnable_init();
        __Ownable_init();
        __UUPSUpgradeable_init();
        __ERC20Capped_init(5000000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _mint(address account, uint256 amount) internal virtual override(ERC20Upgradeable, ERC20CappedUpgradeable) {
        require(totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }


    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
}
