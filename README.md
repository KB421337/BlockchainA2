# GROUP 49 - Blockchain Assignment 2

# Smart Contract

Purchasing goods remotely currently requires multiple parties that need to trust each other. 
With the help of this __smart contract__ the need of _trust_ betweeen parties for an online purchase or transaction is __removed__.

## Problem 

The customer would like to receive an item from the website and the website would like to get money in return. Thus, the problem is 2 fold. First, if the customer pays first they need to trust the website to ship their item.
Second, if the customer orders and does not pay first, the website needs to be sure that the customer will pay the amount when the item reaches them.

## Solution

To solve this problem both parties have to put 1.25 times the value of the item into the contract as escrow. As soon as this happened, the money will stay locked inside the contract until the customer confirms that they received the item. After that, the customer is returned the value (25% of their deposit) and the website gets 2.25 times the value (their deposit plus the selling price). The idea behind this is that both parties have an incentive to resolve the situation or otherwise their money is locked forever, thus removing the need for trust between parties.


## Code Reference




#### Variables

| Variable | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `customer` | `address` | **Required**. Customer's wallet address |                
| `website`      | `address` | **Required**. Website's wallet address |
| `value`      | `uint` | **Required**. Value of item being sold/bought |
| `state`      | `State` | **Required**. Current state of contract `[Activated / Confirmed / Reimbursable / Inactive]` |

#### Functions
| Function  | Description                |
| :-------- | :------------------------- |
| `constructor` |  Initialises contract|                
| `cancel`      |  Abort the purchase and reclaim the ether. Can only be called by the website before the contract is locked.|
| `confirmReceipt`      |  Confirm that you (as customer) have recieved the good. This will unlock the locked amount |
| `confirmTransaction`      |  Confirm purchase as customer by sending 1.25 times the value that will be locked until confirmReceived|
| `reimburseWebsite`      |  Return the website 2.25 times the value (deposit + cost)|

## Group Details

### GROUP 49

| Name | ID     | 
| :-------- | :------- |
| `Kaustubh Bhanj` | `2019A7PS0009H` | 
| `Dhruv Gupta` | `2019B3A70487H` |
| `Gaurav Sinha` | `2019A7PS0131H` |  