
// SPDX-License-Identifier: MIT

/*To create a new logic for calculating the current state of the proposal based on the votes, we can modify the existing implementation to have a different success condition. Here's a new logic for calculating the current state:
New Logic for Current State Calculation:

- **Success Condition**: For a proposal to succeed, the number of approve votes should be more than twice the number of reject votes. In other words, the formula would be `approve > reject * 2`.
- **Implementation Details**:
    - If the number of approve votes is more than twice the reject votes, the proposal will be considered successful.
    - Otherwise, the proposal will fail.

### Implementation in Solidity Code: */


pragma solidity ^0.8.0;

contract ProposalContract {
    struct Proposal {
        uint256 approve;
        uint256 reject;
    }

    Proposal[] public proposal_history;
    uint256 counter;

    function calculateCurrentState() public view returns (bool) {
        Proposal storage proposal = proposal_history[counter];
        
        if (proposal.approve > proposal.reject * 2) {
            return true; // Proposal passes
        } else {
            return false; // Proposal fails
        }
    }
}

/* ### Explanation:
1. We modify the `calculateCurrentState()` function to implement the new logic for determining whether a proposal is successful or not based on the number of approve and reject votes.
2. The function checks if the number of approve votes is more than twice the number of reject votes. If this condition is met, the proposal is considered successful (`true` is returned), otherwise, it fails (`false` is returned).

By implementing this new logic in the `calculateCurrentState()` function, the contract will now determine the success or failure of a proposal based on the updated condition of approve votes being more than twice the reject votes. */