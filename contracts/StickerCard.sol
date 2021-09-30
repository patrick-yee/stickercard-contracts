pragma solidity ^0.5.11;

import "./ERC1155Tradable.sol";
import 'multi-token-standard/contracts/utils/SafeMath.sol';

/**
 * @title Stickercard
 * Stickercard - a contract for my semi-fungible tokens.
 */
contract StickerCard is ERC1155Tradable {

    // The 0 index token is the card
    uint256 public constant CARD = 0;

    // Any token with index greater than 0 is a sticker
    uint256 public constant FARMER = 1;
    uint256 public constant VERIFIED_DEGEN = 2;
    uint256 public constant I_LOVE_CRYPTO = 3;
    uint256 public constant TOP_10K_GAMER = 4;
    uint256 public constant NFT_COLLECTOR = 5;
    uint256 public constant OG_NFT_COLLECTOR = 6;
    uint256 public constant CAMP_BTC = 7;
    uint256 public constant CAMP_ETH = 8;
    uint256 public constant I_GOT_RUGGED = 9;

    // Max supply for the first run is 10,000 cards
    uint constant maxSupply = 10000;

    // The first 2000 cards will be free
    uint constant freeSupply = 2000;

    // Price used for cards once the free supply is gone
    uint public constant basePrice = 180000000000000000;


  constructor(address _proxyRegistryAddress)
  ERC1155Tradable(
    "StickerCard",
    "STCKRCRD",
    _proxyRegistryAddress
  ) public {
    _setBaseMetadataURI("https://gateway.pinata.cloud/ipfs/QmWAdCjZf7itTzmTGuqvdWcAUK27YVe5tYt2KJhUfnLVHd/{id}.json");
  }

  function contractURI() public view returns (string memory) {
    return "https://gateway.pinata.cloud/ipfs/QmNt1BAKRBUnwSBEew9kDkRk3miC5mE1KDzgtGWoXYMhe7/contract_manifest.json";
  }

  // purposely no-op.  transfers of any token that is not the card are not allowed.
  function safeBatchTransferFrom(address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public 
  {
    require(1 < 0, "Transfers of stickers are not allowed");
  }

  // transfer fee comes into play here
  function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes memory data) public
  {
    // check that no stickers have been attached to the given card
    require(((balanceOf(from, FARMER) == 0) &&
              (balanceOf(from, VERIFIED_DEGEN) == 0) &&
              (balanceOf(from, I_LOVE_CRYPTO) == 0) &&
              (balanceOf(from, TOP_10K_GAMER) == 0) &&
              (balanceOf(from, NFT_COLLECTOR) == 0) &&
              (balanceOf(from, OG_NFT_COLLECTOR) == 0) &&
              (balanceOf(from, CAMP_BTC) == 0) &&
              (balanceOf(from, CAMP_ETH) == 0) &&
              (balanceOf(from, I_GOT_RUGGED) == 0)), 
              "Card is not transferrable after stickers have been attached");
            
    // only the card is transferrable
    require(id == 0, "Only the card itself is transferrable");

    // now call the master transfer method
    _safeTransferFrom(from, to, id, amount);
  }
}
