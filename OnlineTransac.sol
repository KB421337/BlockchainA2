// BITS F452: Blockchain Technology - Assignment 2
// - Gaurav Sinha                 | 2019A7PS0131H
// - Kaustubh Bhanj               | 2019A7PS0009H
// - Dhruv Gupta                  | 2019B3A70487H



// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;
contract OnlineTransac 
{
    uint public value;
    address payable public website;
    address payable public customer;
    enum State {Activated, Confirmed, Reimbursable, Inactive} // The state variable will have 1st member as default value
    State public state;
  
    error InvalidState(); // This function cannot be called from the current state
    error OnlyCustomer(); // Only the customer can call this function
    error OnlyWebsite(); // Only the website can call this function
 
    modifier condition(bool condition_) 
    {
        require(condition_);
        _;
    }
    modifier onlyCustomer() 
    {
        if (msg.sender != customer)
            revert OnlyCustomer();
        _;
    } 
    modifier onlyWebsite() 
    {
        if (msg.sender != website)
            revert OnlyWebsite();
        _;
    } 
    modifier inState(State state_) 
    {
        if (state != state_)
            revert InvalidState();
        _;
    }
 
    event Cancelled();
    event TransactionConfirmed();
    event ItemReceived();
    event WebsiteReimbursed();
 
    constructor() payable 
    {
        website = payable(msg.sender);
        value = (msg.value*4)/5;
    }
 
    // To cancel the OnlineTransac and reclaim the money:
    // (Can only be called by the website before the state changes)
    function cancel()
        external
        onlyWebsite
        inState(State.Activated)
    {
        emit Cancelled();
        state = State.Inactive;
        website.transfer(address(this).balance);
    }
 
    // To confirm the Online Transaction:
    // (Can only be called by the customer)
    // (The transaction has to include `1.25*cost`, 
    // and the additional deposit is locked until the receiving of goods is confirmed)
    function confirmTransaction()
        external
        inState(State.Activated)
        condition(msg.value == ((5*value)/4))
        payable
    {
        emit TransactionConfirmed();
        customer = payable(msg.sender);
        state = State.Confirmed;
    }
 
    // To confirm the receipt of the item by the customer: 
    // (So that the locked deposits can be released)
    function confirmReceipt()
        external
        onlyCustomer
        inState(State.Confirmed)
    {
        emit ItemReceived();
        state = State.Reimbursable; 
        customer.transfer((value/4));
    }
 
    // To reimburse the website:
    // (Pays back the locked deposit of the website)
    function reimburseWebsite()
        external
        onlyWebsite
        inState(State.Reimbursable)
    {
        emit WebsiteReimbursed();
        state = State.Inactive; 
        website.transfer((9*value)/4);
    }
}