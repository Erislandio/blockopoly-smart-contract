// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Bank {
    address public minter = msg.sender;
    mapping(address => uint256) private balances;

    event Sent(address from, address to, uint256 amount);

    function mint(address receiver, uint256 amount) public {
        require(msg.sender == minter, "Sender is not minter");
        require(amount < 1e60, "Amount isn't too big");

        balances[receiver] += amount;
    }

    function sendMoney(
        address receiver,
        address sender,
        uint256 amount
    ) public {
        require(
            msg.sender == minter,
            "Only the banker can authorize transfers!"
        );
        require(amount <= balances[sender], "Insufficient balace.");
        balances[sender] -= amount;
        balances[receiver] += amount;

        emit Sent(sender, receiver, amount);
    }

    function getBalance(address account) public view returns (uint256) {
        require(
            msg.sender == account || msg.sender == minter,
            "You cannot get a balance on someone else's account"
        );
        return balances[account];
    }
}
