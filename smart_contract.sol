pragma solidity ^0.5.4;
contract Roommate {
    address payable[] roommates;
    mapping (uint => bool) taskComplete;
    uint taskId;
    uint startTime;
    uint constant FIVE = 5 days;
    uint constant SEVEN = 7 days;
    uint constant MIN_STAKE = 100000000000000000;
    uint totalRoommates;

    constructor(uint totalRoommates_) public {
        totalRoommates = totalRoommates_;
    } 

    modifier onlyRoommate() {

    } 

    // anyone putting up stake is added as a roommate and given a task id
    // index in roommate array is their assigned taskId
    function assign() public payable {
        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }		
    }

    function done(uint taskId_) public onlyRoommate {

    }
}