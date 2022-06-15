pragma solidity ^0.5.0;
// the contract allows only its creator to create new coins 
// anyone can send coins to eachother without a need for signup all need is etherium keypair
/*in this contrcata 1. we create coins
                    2. we send coins
                    3. we give date of the coins  
                    4. if there is an error we revert the transaction
                    */
contract coin{
    address public minter;
    mapping(address=> uint) public balances; 
    //event are used to inform the calling application about the current state of the contract, with the help of the logging facility of EVM
    //events react to specific changes made in the contract.
    event sent(address from, address to, uint amount);   
// constructor is a special fuction that onlyb runs when we deploy the contract
    constructor(){
        minter=msg.sender;
    }
    //make new coins and send them to an address, and only the owner can send these coins
      function mint(address reciver, uint amount) public {
        require(msg.sender == minter);
        balances[reciver] += amount;
    }
 //send any amount of coins to an exsisting address
   error InsufficientBalance(uint requested, uint available);
    function send(address reciver, uint amount )public{
        //requier amount to be greater than x and then run this;
        if(amount>balanaces[msg.sender])
        revert InsufficientBalance({
            requested:amount,
            available:balances[msg.sender]//this is object so ';' not required
            });//stops the functions and gives coin data.
        balances[msg.sender]-=amount;
        balances[reciver]+=amount;
        //  this is used to emit the event of the contract.
        emit sent(msg.sender,reciver,amount);
    }

} 
