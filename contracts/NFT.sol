// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; // this is our Counter variable, keeps track of tokenIds.

    constructor() ERC721("catNFT", "CAT") {
        console.log("This is my NFT contract!");
    }

    // function for minting NFT to user
    function mintCatNFT() public {
        // get current tokenId (starts at 0). This keeps track of each individual NFT within the collection.
        uint256 newItemId = _tokenIds.current();

        // Mint NFT to sender and give the NFT the current tokenId.
        _safeMint(msg.sender, newItemId);

        // set the data of the NFT with the specified newItemId.
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/IK53");

        console.log("Minted NFT # %s to %s", newItemId, msg.sender);
        // Increment the counter to the ID of the next NFT to be minted.
        _tokenIds.increment();
    }
}
