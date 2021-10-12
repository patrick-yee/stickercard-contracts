const StickerCard = artifacts.require("StickerCard");
//const MyLootBox = artifacts.require("MyLootBox");
const StickerCardFactory = artiface.require("StickerCardFactory");

// Set to false if you only want the collectible to deploy
const ENABLE_LOOTBOX = false;
// Set if you want to create your own collectible
const NFT_ADDRESS_TO_USE = 0xFAFd765A977b6839B37F89d2460A6E1D7aeD87a3; // e.g. Enjin: '0xfaafdc07907ff5120a76b34b731b278c38d6043c'
// If you want to set preminted token ids for specific classes
const TOKEN_ID_MAPPING = undefined; // { [key: number]: Array<[tokenId: string]> }

module.exports = function(deployer, network) {
  // OpenSea proxy registry addresses for rinkeby and mainnet.
  let proxyRegistryAddress;
  if (network === 'rinkeby') {
    proxyRegistryAddress = "0xf57b2c51ded3a29e6891aba85459d600256cf317";
  } else {
    proxyRegistryAddress = "0xa5409ec958c83c3f309868babaca7c86dcb077c1";
  }

  if (!ENABLE_LOOTBOX) {
    deployer.deploy(StickerCard, proxyRegistryAddress,  {gas: 5000000}).then(setupFactory);
  }/* else if (NFT_ADDRESS_TO_USE) {
    deployer.deploy(MyLootBox, proxyRegistryAddress, NFT_ADDRESS_TO_USE, {gas: 5000000})
      .then(setupLootbox);
  } else {
    deployer.deploy(StickerCard, proxyRegistryAddress, {gas: 5000000})
      .then(() => {
        return deployer.deploy(MyLootBox, proxyRegistryAddress, MyCollectible.address, {gas: 5000000});
      })
      .then(setupLootbox);
  }*/
};


async function setupFactory() {
  if (!NFT_ADDRESS_TO_USE) {
    const collectible = await StickerCard.deployed();
    //await collectible.transferOwnership(StickerCardFato.address);
  }
  else{
    deployer.deploy(StickerCardFactory, proxyRegistryAddress, NFT_ADDRESS_TO_USE);
  }

  
/*
  if (TOKEN_ID_MAPPING) {
    //const lootbox = await MyLootBox.deployed();
    for (const rarity in TOKEN_ID_MAPPING) {
      console.log(`Setting token ids for rarity ${rarity}`);
      const tokenIds = TOKEN_ID_MAPPING[rarity];
      //await lootbox.setTokenIdsForClass(rarity, tokenIds);
    }
  }
  */
}