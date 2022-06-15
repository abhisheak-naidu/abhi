pragma solidity ^0.8.4;

contract coin{

    address public minter;
    mapping(address => uint) public balances;

    event sent(address from, address to, uint amount);

    constructor() {
        minter = msg.sender;
    }

    function mint(address reciver, uint amount) public {
        require(msg.sender == minter);
        balances[reciver] += amount;
    }
    error InsufficientBalance(uint requested, uint available);

    function send(address reciver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance ({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[reciver] += amount;
        emit sent(msg.sender, reciver, amount);
    }
}
