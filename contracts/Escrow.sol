// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
    // State variables
    address public arbiter;
    address public beneficiary;
    address public depositor;
    bool public isApproved;

    // Events
    event Approved(uint256);

    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function approve() external isArbiter {
        uint256 balance = address(this).balance;
        (bool sent, ) = payable(beneficiary).call{value: balance}("");
        require(sent, "Failed to send Ether");
        emit Approved(balance);
        isApproved = true;
    }

    modifier isArbiter() {
        require(msg.sender == arbiter, "Caller is not the arbiter");
        _;
    }
}
