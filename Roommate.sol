/**
* Computer Security Assignment 4
* Smart Contract to Incentivize roommates upon task completion.
* @author Adeel Malik
* @author Nazia Sharmin
*/

pragma solidity ^0.5.4;
contract Roommate {
   address payable[] roommates;
   mapping (uint => bool) taskComplete;
   uint taskId;
   uint roommateCount = 0;
   uint constant FIVE = 5 days; 
   uint constant SEVEN = 7 days; 
   uint constant MIN_STAKE = 100000000000000000;
   uint totalRoommates;
   uint256 softDeadLine; 
   uint256 hardDeadLine;
   
   constructor(uint totalRoommates_) public {
       totalRoommates = totalRoommates_;
   } 

   modifier onlyRoommate() {
       bool isRoommate = false;
       for(uint i=0; i<roommates.length; i++) {
           if (roommates[i] == msg.sender){
               isRoommate = true;
           }
       }
       require(isRoommate);
      _;
   } 

   // anyone putting up stake is added as a roommate and given a task id 
   // index in roommate array is their assigned taskId
   function assign() public payable {
       roommates.push(msg.sender);
       require(msg.value >= MIN_STAKE, "You need to send at least 0.1 ether");
       taskComplete[roommateCount] = false; //roommate is assigned a task and its not complete yet
       roommateCount++; //increment roommateCount to handle the next roommate
       if (roommateCount == totalRoommates) {//if all roommates added, start time lines
           softDeadLine = now + FIVE;
           hardDeadLine = now + SEVEN;
       } 
   }

   function done(uint taskId_) public onlyRoommate {//task must be complete to payback
       //check if the task is complete first and within timelimit
       if (now < softDeadLine){ //if the task is still under softDeadLine, only the owner of the task can complete it
           if (roommates[taskId_]==msg.sender){
               address(msg.sender).transfer(MIN_STAKE);
               taskComplete[taskId_] = true;
           }
       }else if (now < hardDeadLine){//after the softDeadLine and before hardDeadLine anyone can do the task and claim the ether
               address(msg.sender).transfer(MIN_STAKE);   
               taskComplete[taskId_] = true;
       }
   }
}