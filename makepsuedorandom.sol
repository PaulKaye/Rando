// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract RandomNumberGenerator {
    IERC20 public randoToken;

    event RandomNumberGenerated(address indexed player, uint256 randomNumber);

    constructor(IERC20 _tokenAddress) {
        randoToken = _tokenAddress; //assign the passed address to our randoToken IERC20 instance
    }

    function generateRandomNumber() external returns (uint256){
        require(randoToken.balanceOf(msg.sender) >= 1 ether, "Not Enough RANDO balance");
        require(randoToken.transferFrom(msg.sender, address(this), 1 ether), "Something went wrong during the transfer");
        
        bytes32 blockHash = blockhash(block.number - 1); 
        uint256 randomNumber = uint256(blockHash) % 100; 

        emit RandomNumberGenerated(msg.sender, randomNumber);
        return randomNumber;
    }
}