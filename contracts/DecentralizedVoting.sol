
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DecentralizedVoting {
    address public owner;

    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    Candidate[] private candidates;

    mapping(address => bool) public registeredVoters;
    mapping(address => bool) public hasVoted;

    bool public registrationOpen = true;
    bool public votingStarted = false;
    bool public votingEnded = false;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string calldata name) external onlyOwner {
        require(registrationOpen, "Candidate registration is closed");
        require(bytes(name).length > 0, "Candidate name cannot be empty");

        uint256 id = candidates.length;
        candidates.push(Candidate(id, name, 0));

        emit CandidateAdded(id, name);
    }

    function registerVoter() external {
        require(registrationOpen, "Registration is closed");
        require(!registeredVoters[msg.sender], "Already registered");

        registeredVoters[msg.sender] = true;
        emit VoterRegistered(msg.sender);
    }

    function closeRegistration() external onlyOwner {
        require(registrationOpen, "Registration already closed");
        registrationOpen = false;
        emit RegistrationClosed();
    }

    function startVoting() external onlyOwner {
        require(!registrationOpen, "Close registration first");
        require(!votingStarted, "Voting has already started");
        require(!votingEnded, "Voting has ended");
        require(candidates.length >= 2, "Add at least two candidates");

        votingStarted = true;
        emit VotingStarted();
    }

    function castVote(uint256 candidateId) external {
        require(votingStarted, "Voting is not active");
        require(!votingEnded, "Voting has ended");
        require(registeredVoters[msg.sender], "Register before voting");
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateId < candidates.length, "Invalid candidate ID");

        hasVoted[msg.sender] = true;
        candidates[candidateId].voteCount++;

        emit VoteCast(msg.sender, candidateId);
    }

    function endVoting() external onlyOwner {
        require(votingStarted, "Voting has not started");
        require(!votingEnded, "Voting already ended");

        votingEnded = true;
        votingStarted = false;
        emit VotingEnded();
    }

    function getCandidates() external view returns (Candidate[] memory) {
        return candidates;
    }

    function getCandidateCount() external view returns (uint256) {
        return candidates.length;
    }

    event VoterRegistered(address indexed voter);
    event CandidateAdded(uint256 indexed id, string name);
    event VoteCast(address indexed voter, uint256 indexed candidateId);
    event RegistrationClosed();
    event VotingStarted();
    event VotingEnded();
}
