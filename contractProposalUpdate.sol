
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProposalContract {
    uint256 private counter;
    
    struct Proposal {
        string title; // New field for the title of the proposal
        string description;
        uint256 approve;
        uint256 reject;
        uint256 pass;
        uint256 total_vote_to_end;
        bool current_state;
        bool is_active;
    }

    mapping(uint256 => Proposal) proposal_history;

    function create(string calldata _title, string calldata _description, uint256 _total_vote_to_end) external {
        counter += 1;
        proposal_history[counter] = Proposal(_title, _description, 0, 0, 0, _total_vote_to_end, false, true);
    }
}

/*
With these updates:
- The `create` function now takes three parameters: `_title`, `_description`, and `_total_vote_to_end`.
- When calling the `create` function, you need to provide the title, description, and total votes required for the proposal.
- The function creates a new proposal with the provided title, description, and vote requirements, and adds it to the `proposal_history` mapping with a unique identifier obtained from the `counter`.

This modification allows you to create proposals with titles in addition to descriptions. */

