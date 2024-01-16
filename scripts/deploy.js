const { ethers } = require("hardhat");

async function main() {
  const CoinFlip = await ethers.getContractFactory("CoinFlip");
  const coinFlipInstance = await CoinFlip.deploy();

  console.log("CoinFlip deployed to:", coinFlipInstance.target);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
