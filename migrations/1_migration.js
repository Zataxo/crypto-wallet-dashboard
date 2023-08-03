const CryptoWallet = artifacts.require("CryptoWallet");
module.exports = function(deployer){
    deployer.deploy(CryptoWallet);
}