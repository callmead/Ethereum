pragma solidity ^0.5.7;
contract Incentivize {
	address[] payable[] roommates; 			//Roommates array
	mapping (uint => bool) taskComplete;	//
	unit totalReceived = 0;					//
	//unit userShare = 0.1;					//initial investment
	uint constant MIN_STAKE = 100000000000000000; 
	bool timeStarted;						//week time started
	unit softDeadline, hardDeadline;		//5 and 7 days work limits
	
	constructor() public payable {
        roommates = msg.sender;
        investment = msg.value;
		selectedTask = msg.value
        timeStarted = false;
    }

	checkAssignedTasks(){
		if
	}
	
	startTime(){
		softDeadline = now + (5 * 1 days);
		hardDeadline = now + (7 * 1 days);
	}
	
	function assign(investment) public {
		totalReceived += msg.value; 
	}
	
	function done(unit taskid) public onlyRoommate{
	
	}
}
//examples: https://capturetheether.com/challenges/
//Time: https://programtheblockchain.com/posts/2018/01/12/writing-a-contract-that-handles-time/
//deadline : deadline = now + (numberOfDays * 1 days);
//deadline: https://programtheblockchain.com/posts/2018/01/12/writing-a-contract-that-handles-time/
//withdraw: https://programtheblockchain.com/posts/2018/01/19/writing-a-crowdfunding-contract-a-la-kickstarter/
//https://www.youtube.com/watch?v=TC-bDQZbXd0

//https://github.com/pbrudny/learning-solidity-2018