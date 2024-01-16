// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {
    address public owner;
    uint256 public betAmount = 0.001 ether;
    uint256 public lastFlipTimestamp;
    bool public lastFlipResult;

    event CoinFlipped(address indexed player, bool result, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function flipCoin() external payable {
        require(msg.value == betAmount, "Incorrect bet amount");
        require(block.timestamp - lastFlipTimestamp > 5 minutes, "Wait for at least 5 minutes between flips");

        lastFlipTimestamp = block.timestamp;
        lastFlipResult = getRandomResult();
        emit CoinFlipped(msg.sender, lastFlipResult, msg.value);

        if (lastFlipResult) {
            // Player wins, transfer double the amount
            payable(msg.sender).transfer(msg.value * 2);
        }
    }

    function getRandomResult() internal view returns (bool) {
        return uint256(blockhash(block.number - 1)) % 2 == 0;
    }

    function withdrawBalance() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
