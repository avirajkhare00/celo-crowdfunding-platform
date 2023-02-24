require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
    },
    alfajores: {
      url: "https://alfajores-forno.celo-testnet.org",
      accounts: ["YOUR_PRIVATE_KEY_HERE"]
    },
  },
};
