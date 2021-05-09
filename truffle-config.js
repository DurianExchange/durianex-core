const HDWalletProvider = require('truffle-hdwallet-provider');
const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();
const mnemonicTestnet = fs.readFileSync(".secret-testnet").toString().trim();

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 8545,            // Standard BSC port (default: none)
      network_id: "*",       // Any network (default: none)
    },
    testnet: {
      provider: () => new HDWalletProvider(mnemonicTestnet, `https://data-seed-prebsc-1-s1.binance.org:8545`, 0, 10),
      network_id: 97,
      confirmations: 2,
      timeoutBlocks: 200,

    },
    mainnet: {
      provider: () => new HDWalletProvider(mnemonic, `https://bsc-dataseed1.binance.org`),
      network_id: 56,
      confirmations: 2,
      timeoutBlocks: 200,
    },
  },
  mocha: {
    // timeout: 100000
  },
  compilers: {
    solc: {
      version: "0.5.16",
      // docker: true,
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
        evmVersion: "istanbul",
        outputSelection: {
          "*": {
            "": [
              "ast"
            ],
            "*": [
              "evm.bytecode.object",
              "evm.deployedBytecode.object",
              "abi",
              "evm.bytecode.sourceMap",
              "evm.deployedBytecode.sourceMap",
              "metadata"
            ]
          },
        }
      }
    },
  }
}