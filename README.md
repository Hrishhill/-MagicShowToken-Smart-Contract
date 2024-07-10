 -MagicShowToken-Smart-Contract
The MagicShowToken is an ERC-20 token contract designed for use on the Avalanche network.
MagicShowToken Smart Contract

 Overview

The `MagicShowToken` is an ERC-20 token contract designed for use on the Avalanche network. This contract includes additional functionalities to support a gaming platform where players can mint, transfer, redeem, check balance, and burn tokens. The contract is built using the OpenZeppelin library for enhanced security and functionality.

 Contract Details

 Token Information

- Name: MagicShow
- Symbol: MST

 Functionalities

1. Minting New Tokens
   - Only the owner of the contract can mint new tokens.
   - The minted tokens can be distributed to players as rewards.

2. Transferring Tokens
   - Players can transfer their tokens to other players.

3. Redeeming Tokens
   - Players can redeem their tokens for magical items in the in-game store.
   - The items available are Wand, Hat, Cloak, and Potion.

4. Checking Token Balance
   - Players can check their token balance at any time.

5. Burning Tokens
   - Any player can burn their own tokens when they are no longer needed.

 Smart Contract Code

```solidity
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
```

 Detailed Functionality

 Minting New Tokens

- Function: `mintTokens(address to, uint256 amount)`
- Access Control: `onlyOwner`
- Description: This function allows the owner of the contract to mint new tokens and distribute them to a specified address. This is particularly useful for rewarding players.

Transferring Tokens

- Function: `transferTokens(address to, uint256 amount)`
- Description: This function enables players to transfer their tokens to another player's address. It uses the internal `_transfer` function from the ERC-20 standard to handle the transfer process.

 Redeeming Tokens

- Function: `redeemItem(MagicalItem item)`
- Description: Players can redeem their tokens for various magical items. The function checks the balance of the player to ensure they have enough tokens to redeem the item. If they do, the corresponding number of tokens are burned and the player's inventory is updated with the new item.

 Checking Token Balance

- **Function:** `checkBalance(address account)`
- **Description:** This view function allows any user to check the token balance of a specified account. It uses the `balanceOf` function from the ERC-20 standard to retrieve the balance.

 Burning Tokens

- **Function:** `burnTokens(uint256 amount)`
- **Description:** Any player can burn a specified amount of their own tokens using this function. This helps to manage the token supply and allows players to dispose of tokens that are no longer needed.

 Deployment Instructions

1. Compile the Contract:
   - Use Remix IDE or another Solidity compiler to compile the `MagicShowToken` contract.

2. Deploy the Contract:
   - Deploy the contract to the Avalanche Fuji Testnet using MetaMask connected to the testnet.
   - Ensure you have test AVAX tokens in your MetaMask wallet for gas fees.

3. Verify the Contract:
   - Verify the deployed contract on Snowtrace to make the contract details publicly available.

Testing the Contract

1. Minting Tokens:
   - Use the `mintTokens` function to create new tokens and distribute them to a player's address.
   - Ensure only the owner can call this function.

2. Transferring Tokens:
   - Transfer tokens from one player to another using the `transferTokens` function.
   - Verify the balances of both the sender and the receiver after the transfer.

3. Redeeming Tokens:
   - Redeem tokens for magical items using the `redeemItem` function.
   - Check the player's balance and inventory to ensure the tokens were deducted and the item was added.

4. Checking Balance:
   - Use the `checkBalance` function to check the token balance of various accounts.

5. Burning Tokens:
   - Burn tokens using the `burnTokens` function.
   - Verify that the tokens are removed from the player's balance.

Conclusion

The `MagicShowToken` smart contract provides a comprehensive solution for managing an in-game token economy on the Avalanche network. It ensures controlled token minting, seamless token transfers, interactive item redemption, transparent balance checking, and efficient token burning, all tailored for an engaging gaming experience.
**This is the vdo description**
https://drive.google.com/file/d/1q0EMgTdQjLXIoRW8pHXEfyay3_BbgitB/view?usp=sharing
