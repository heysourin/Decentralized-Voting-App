require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const NODE_HTTP_URL = process.env.NODE_HTTP_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: NODE_HTTP_URL,
      accounts: [PRIVATE_KEY],
    },
  },
};
