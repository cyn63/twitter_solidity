require("@nomicfoundation/hardhat-toolbox");

const ALCHEMY_API_KEY = "UiZH20_tEyGRDxvtlp7zhn1ye3t819qC";

const GOERLI_PRIVATE_KEY =
  "893971ff77660f6a715bdbe76bac3859ac97f0f492cadb09f71cb1a24c2f39e1";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [GOERLI_PRIVATE_KEY],
    },
  },
};
