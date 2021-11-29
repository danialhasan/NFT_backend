// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; // this is our Counter variable, keeps track of tokenIds.

    constructor() ERC721("catNFT", "CAT") {
        console.log("This is my NFT contract!");
    }

    // Arrays of word that will be randomly used to generate NFT words.
    string[] sizeSet = [
        "Huge",
        "Big",
        "Small",
        "Tiny",
        "Miniscule",
        "UltraWide",
        "Baby",
        "Enormous",
        "Micro",
        "Immense",
        "Sizeable",
        "Substantial",
        "Colossal",
        "Great",
        "Massive",
        "Weighty",
        "FuckingHuge",
        "FuckingBig",
        "FuckingSmall",
        "FuckingTiny",
        "FuckingMiniscule",
        "FuckingUltraWide",
        "FuckingBaby",
        "FuckingEnormous",
        "FuckingMicro",
        "FuckingImmense",
        "FuckingSizeable",
        "FuckingSubstantial",
        "FuckingColossal",
        "FuckingGreat",
        "FuckingMassive",
        "FuckingWeighty"
    ];
    string[] colorSet = [
        "Black",
        "White",
        "Beige",
        "Red",
        "Blue",
        "Grey",
        "Yellow",
        "Brown",
        "Green",
        "Purple",
        "Iridescant",
        "Sparkling",
        "DarkBlack",
        "DarkWhite",
        "DarkBeige",
        "DarkRed",
        "DarkBlue",
        "DarkGrey",
        "DarkYellow",
        "DarkBrown",
        "DarkGreen",
        "DarkPurple",
        "LightBlack",
        "LightWhite",
        "LightBeige",
        "LightRed",
        "LightBlue",
        "LightGrey",
        "LightYellow",
        "LightBrown",
        "LightGreen",
        "LightPurple"
    ];
    string[] speciesSet = [
        "Jaguar",
        "Tiger",
        "Lion",
        "Cougar",
        "Minx",
        "Bobcat",
        "Pussycat",
        "Cheetah",
        "Jungle Cat",
        "Leopard",
        "Cat",
        "EndangeredCheetah",
        "EndangeredJungle Cat",
        "EndangeredLeopard"
    ];

    // base SVG string all our dynamically-created NFTs are based off of.
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // Random Word Generator functions

    function pickFirstRandomWord(uint256 tokenId)
        private
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        rand = rand % sizeSet.length;
        return sizeSet[rand];
    }

    function pickSecondRandomWord(uint256 tokenId)
        private
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % colorSet.length;
        return colorSet[rand];
    }

    function pickThirdRandomWord(uint256 tokenId)
        private
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % speciesSet.length;
        return speciesSet[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // function for minting NFT to user
    function mintCatNFT() public {
        // get current tokenId (starts at 0). This keeps track of each individual NFT within the collection.
        uint256 newItemId = _tokenIds.current();

        // get random words.
        string memory firstWord = pickFirstRandomWord(newItemId);
        string memory secondWord = pickSecondRandomWord(newItemId);
        string memory thirdWord = pickThirdRandomWord(newItemId);
        string memory combinedWord = string(
            abi.encodePacked(firstWord, secondWord, thirdWord)
        );

        // concat all words into svg, then base64 encode it.
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, combinedWord, "</text></svg>")
        );
        console.log("Final SVG:");

        console.log("----------------");
        console.log(finalSvg);
        console.log("----------------");

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of cats.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        // Mint NFT to sender and give the NFT the current tokenId.
        _safeMint(msg.sender, newItemId);

        // set the data of the NFT with the specified newItemId.
        _setTokenURI(newItemId, finalTokenUri);
        console.log("Minted NFT # %s to %s", newItemId, msg.sender);
        // Increment the counter to the ID of the next NFT to be minted.
        _tokenIds.increment();
    }
}
