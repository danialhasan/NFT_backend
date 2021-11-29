const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("NFT");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Deployed contract to ", nftContract.address);
    let txn;
    for (let index = 0; index <= 100; index++) {
        txn = await nftContract.mintCatNFT();
        await txn.wait();
    }
};

main()
    .then(() => {
        process.exit(0);
    })
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
