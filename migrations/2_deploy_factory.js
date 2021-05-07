const DurianFactory = artifacts.require("DurianFactory");

module.exports = function (deployer, network, accounts) {
  let currentAccount = accounts[0]
  if(network == 'testnet') {
    console.warn('WARNING: Using account[1] for testnet')
    currentAccount = accounts[1]
  }
  deployer.deploy(DurianFactory, currentAccount, {from: currentAccount});
};