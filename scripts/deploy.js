const hre = require("hardhat");

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const Twitter = await hre.ethers.getContractFactory("Twitter");
  const twitter = await Twitter.deploy();

  await twitter.deployed();

  console.log(
    `Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${twitter.address}`,
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
