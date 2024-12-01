// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner;

    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
    }

    // Returns the actual contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function deposit() public payable {
        require(msg.sender == owner, "You are not the owner of this account");
        require(msg.value > 0, "Deposit amount must be greater than 0");

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        require(address(this).balance >= _amount, "Insufficient balance");

        // Withdraw the given amount
        payable(msg.sender).transfer(_amount);

        emit Withdraw(msg.sender, _amount);
    }

    function burn(uint256 _amount) public {
        require(address(this).balance >= _amount, "Insufficient balance");
        // Reduce the contract's Ether balance
        payable(0).transfer(_amount);

        emit Withdraw(msg.sender, _amount);
    }
}
