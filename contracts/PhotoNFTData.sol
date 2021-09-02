pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import { PhotoNFTDataStorages } from "./photo-nft-data/commons/PhotoNFTDataStorages.sol";
import { PhotoNFT } from "./PhotoNFT.sol";


/**
 * @notice - This is the storage contract for photoNFTs
 */
contract PhotoNFTData is PhotoNFTDataStorages {

    address[] public photoAddresses;

    mapping(address => uint256) public priceTick;

    mapping(address => mapping(uint256 => uint256)) public priceHistory;

    event UpdatePrice(address indexed owner, address indexed nft, uint256 indexed newPrice);

    constructor() public {}

    /**
     * @notice - Save metadata of a photoNFT
     */
    function saveMetadataOfPhotoNFT(
        address[] memory _photoAddresses, 
        PhotoNFT _photoNFT, 
        string memory _photoNFTName, 
        string memory _photoNFTSymbol, 
        address _ownerAddress, 
        uint _photoPrice, 
        string memory _ipfsHashOfPhoto
    ) public returns (bool) {
        /// Save metadata of a photoNFT of photo
        Photo memory photo = Photo({
            photoNFT: _photoNFT,
            photoNFTName: _photoNFTName,
            photoNFTSymbol: _photoNFTSymbol,
            ownerAddress: _ownerAddress,
            photoPrice: _photoPrice,
            ipfsHashOfPhoto: _ipfsHashOfPhoto,
            status: "Open",
            reputation: 0
        });
        photos.push(photo);

        /// Update photoAddresses
        photoAddresses = _photoAddresses;
    }

    /**
     * @notice only owner able to update price
     */
    function updatePrice(uint256 index, uint256 newPrice) public returns(bool){
        Photo memory photo = photos[index];
        address nftAddress = address(photo.photoNFT);
        require(photo.ownerAddress == msg.sender, "You aren't owner");
        uint256 tick = priceTick[nftAddress] + 1;
        // Store price history
        priceTick[nftAddress] += tick;
        priceHistory[nftAddress][tick] = photo.photoPrice;
        // Update price
        photo.photoPrice = newPrice;
        // Update the photo
        photos[index] = photo;
        emit UpdatePrice(msg.sender, photo.ownerAddress, newPrice);
        return true;
    }

    /**
     * @notice - Update owner address of a photoNFT by transferring ownership
     */
    function updateOwnerOfPhotoNFT(PhotoNFT _photoNFT, address _newOwner) public returns (bool) {
        /// Identify photo's index
        uint photoIndex = getPhotoIndex(_photoNFT);

        /// Update metadata of a photoNFT of photo
        Photo storage photo = photos[photoIndex];
        require (_newOwner != address(0), "A new owner address should be not empty");
        photo.ownerAddress = _newOwner;
    }

    /**
     * @notice - Update status ("Open" or "Cancelled")
     */
    function updateStatus(PhotoNFT _photoNFT, string memory _newStatus) public returns (bool) {
        /// Identify photo's index
        uint photoIndex = getPhotoIndex(_photoNFT);

        /// Update metadata of a photoNFT of photo
        Photo storage photo = photos[photoIndex];
        photo.status = _newStatus;
    }


    ///-----------------
    /// Getter methods
    ///-----------------
    function getPhoto(uint index) public view returns (Photo memory _photo) {
        Photo memory photo = photos[index];
        return photo;
    }

    function getPhotoIndex(PhotoNFT photoNFT) public view returns (uint _photoIndex) {
        address PHOTO_NFT = address(photoNFT);

        /// Identify member's index
        uint photoIndex;
        for (uint i=0; i < photoAddresses.length; i++) {
            if (photoAddresses[i] == PHOTO_NFT) {
                photoIndex = i;
            }
        }

        return photoIndex;   
    }

    function getPhotoByNFTAddress(PhotoNFT photoNFT) public view returns (Photo memory _photo) {
        address PHOTO_NFT = address(photoNFT);

        /// Identify member's index
        uint photoIndex;
        for (uint i=0; i < photoAddresses.length; i++) {
            if (photoAddresses[i] == PHOTO_NFT) {
                photoIndex = i;
            }
        }

        Photo memory photo = photos[photoIndex];
        return photo;
    }

    function getAllPhotos() public view returns (Photo[] memory _photos) {
        return photos;
    }

}