pragma solidity ^0.5.7;
contract Will {
    address owner;
    uint fortune;
    bool isDeceased;
    
    constructor() public payable {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier mustBeDeceased {
        require(isDeceased == true);
        _;
    }
    
    address payable[] public familyWallets;
    mapping (address => uint) public inheritance;
    
    function setInheritance(address payable wallet, uint inheritAmount) public onlyOwner {
        familyWallets.push(wallet);//pushing new addresses to familyWallets
        inheritance[wallet] = inheritAmount;//dictionary stores amounts for wallets(key/val)
    }
    
    function payout() private mustBeDeceased {
        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }
    
    function deceased() public onlyOwner {
        isDeceased = true;
        payout();
    }
}