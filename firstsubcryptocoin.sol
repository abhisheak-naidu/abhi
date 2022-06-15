pragma solidity ^0.5.4;

contract coin{
address public minter;
mapping(address=>uint) public balances;

event sent(address from,address to,uint amount);

constuctor(){
minter=msg.sender;
}

function mint(address reciver,uint amount)public{
require(minter==msg.sender);
balances[reciver]+=amount;
}

error insufficentbalance(uint requested,uint avilable);

function send(address reciver, uint amount)public{
if(amount>balances[msg.sender])
revert insufficentbalance({
requested:amount,
avilable :balances[msg.sender]
});
balances[msg.sender]-=amount;
balances[reciver]+=amount;
emit sent(msg.sender,reciver,amount);
}

}
