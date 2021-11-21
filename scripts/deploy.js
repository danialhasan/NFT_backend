const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("NFT");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Deployed contract to ", nftContract.address);

    // call mintCatNFT function twice and wait for it to be mined.
    let txn = await nftContract.mintCatNFT();
    await txn.wait();

    txn = await nftContract.mintCatNFT();
    await txn.wait();
};

main()
    .then(() => {
        process.exit(0);
    })
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
