// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MagicShowToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("MagicShow", "MST") Ownable(msg.sender) {}

    // Enum for magical items
    enum MagicalItem { Wand, Hat, Cloak, Potion }

    // Struct to store player's magical items balance
    struct PlayerItems {
        uint256 wand;
        uint256 hat;
        uint256 cloak;
        uint256 potion;
    }

    // Mapping from player address to their magical items balance
    mapping(address => PlayerItems) public playerItems;

    // Function to mint new tokens, only callable by the owner
    function mintTokens(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Function to transfer tokens to another address
    function transferTokens(address to, uint256 amount) external {
        _transfer(_msgSender(), to, amount);
    }

    // Function to redeem tokens for magical items
    function redeemItem(MagicalItem item) external {
        uint256 cost;
        if (item == MagicalItem.Wand) {
            cost = 10;
            playerItems[msg.sender].wand += 1;
        } else if (item == MagicalItem.Hat) {
            cost = 20;
            playerItems[msg.sender].hat += 1;
        } else if (item == MagicalItem.Cloak) {
            cost = 30;
            playerItems[msg.sender].cloak += 1;
        } else if (item == MagicalItem.Potion) {
            cost = 40;
            playerItems[msg.sender].potion += 1;
        } else {
            revert("Invalid magical item");
        }
        
        require(balanceOf(msg.sender) >= cost, "Insufficient balance");
        burn(cost);
    }

    // Function to burn tokens, callable by anyone for their own tokens
    function burnTokens(uint256 amount) external {
        burn(amount);
    }

    // Function to check token balance
    function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }
}
