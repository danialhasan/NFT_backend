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
        _setTokenURI(
            newItemId,
            "data:application/json;base64,eyJuYW1lIjoiQmVsbHkiLCJkZXNjcmlwdGlvbiI6IlJlZCBub3NlLiIsImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0FnSUR4emRIbHNaVDR1WW1GelpTQjdJR1pwYkd3NklIZG9hWFJsT3lCbWIyNTBMV1poYldsc2VUb2djMlZ5YVdZN0lHWnZiblF0YzJsNlpUb2dNVFJ3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKaWJHRmpheUlnTHo0S0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krUlhCcFkweHZjbVJJWVcxaWRYSm5aWEk4TDNSbGVIUStDand2YzNablBnPT0ifQ=="
        );
        console.log("Minted NFT # %s to %s", newItemId, msg.sender);
        // Increment the counter to the ID of the next NFT to be minted.
        _tokenIds.increment();
    }
}
