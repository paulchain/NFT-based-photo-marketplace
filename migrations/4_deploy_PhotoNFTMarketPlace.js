const PhotoNFTMarketplace = artifacts.require("PhotoNFTMarketplace");
const PhotoNFTData = artifacts.require("./PhotoNFTData.sol");

const _photoNFTData = PhotoNFTData.address;

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(PhotoNFTMarketplace, _photoNFTData);
};
