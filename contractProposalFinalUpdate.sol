
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProposalContract {
    // Data
    address public owner;
    uint256 private counter;

    struct Proposal {
        string title; // Title of the proposal
        string description; // Description of the proposal
        uint256 approve;
        uint256 reject;
        uint256 total_vote_to_end;
        bool current_state;
        bool is_active;
    }

    mapping(uint256 => Proposal) public proposal_history;
    address[] private voted_addresses;

    // Constructor
    constructor() {
        owner = msg.sender;
        voted_addresses.push(msg.sender);
    }

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier active() {
        require(proposal_history[counter].is_active == true, "Proposal is not active");
        _;
    }

    modifier newVoter(address _address) {
        require(!isVoted(_address), "Address has already voted");
        _;
    }

    // Execute Functions
    function setOwner(address newOwner) external onlyOwner {
        owner = newOwner;
    }

    function create(string calldata _title, string calldata _description, uint256 _total_vote_to_end) external onlyOwner {
        counter += 1;
        proposal_history[counter] = Proposal(_title, _description, 0, 0, _total_vote_to_end, false, true);
    }

    function vote(uint8 choice) external active newVoter(msg.sender) {
        Proposal storage proposal = proposal_history[counter];
        uint256 totalVote = proposal.approve + proposal.reject;

        voted_addresses.push(msg.sender);

        if (choice == 1) {
            proposal.approve += 1;
        } else if (choice == 2) {
            proposal.reject += 1;
        }

        proposal.current_state = calculateCurrentState();
        
        if (totalVote + 1 == proposal.total_vote_to_end) {
            proposal.is_active = false;
            voted_addresses = [owner];
        }
    }

    function calculateCurrentState() public view returns (bool) {
        Proposal storage proposal = proposal_history[counter];
        
        if (proposal.approve > proposal.reject * 2) {
            return true; // Proposal passes
        } else {
            return false; // Proposal fails
        }
    }

    // Query Functions
    function isVoted(address _address) public view returns (bool) {
        for (uint i = 0; i < voted_addresses.length; i++) {
            if (voted_addresses[i] == _address) {
                return true;
            }
        }
        return false;
    }

    function getCurrentProposal() external view returns (Proposal memory) {
        return proposal_history[counter];
    }

    function getProposal(uint256 number) external view returns (Proposal memory) {
        return proposal_history[number];
    }
}


/*
Address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

This revised code includes the requested changes:

1. Added a `title` field to the `Proposal` struct and updated the `create` function to accept and store the title of the proposal.

2. Implemented the `calculateCurrentState` function as per the provided logic to determine whether a proposal passes or fails based on the number of approvals and rejections.

3. Ensured that the contract is fully functioning by making necessary changes and maintaining proper functionality throughout the contract.

You can deploy and interact with this smart contract to create proposals, vote on them, and check their current state based on the criteria specified in the `calculateCurrentState` function.
*/
