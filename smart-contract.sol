// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Declare a structure to represent a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Declare a mapping to store the candidates
    mapping(uint => Candidate) public candidates;
    
    // Declare a mapping to track if an address has voted
    mapping(address => bool) public voters;

    // Declare a variable to store the number of candidates
    uint public candidatesCount;

    // Declare an event to emit when a vote is cast
    event Voted(address indexed voter, uint indexed candidateId);

    // Constructor to initialize the contract with candidates
    constructor() {
        addCandidate("Alice");
        addCandidate("Bob");
    }

    // Function to add a new candidate
    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function for a voter to cast their vote
    function vote(uint _candidateId) public {
        // Check that the voter hasn't already voted
        require(!voters[msg.sender], "You have already voted.");
        
        // Check if the candidate ID is valid
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");

        // Mark the sender as having voted
        voters[msg.sender] = true;

        // Increment the vote count for the selected candidate
        candidates[_candidateId].voteCount++;

        // Emit the vote event
        emit Voted(msg.sender, _candidateId);
    }

    // Function to get the total votes for a candidate
    function getVoteCount(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");
        return candidates[_candidateId].voteCount;
    }
}
