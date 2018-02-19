contract SimpleTokenCoin is BurnableToken {
    
    address public forBounty = 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c;
    address public forTeam = 0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db;
    address public forFund = 0x583031d1113ad414f02576bd6afabfb302140225;
    address public forLoyalty = 0xdd870fa1b7c4700f2bd7f44238821c26f7392148;
    address public multisig = 0xdd870fa1b7c4700f2bd7f44238821c26f7392148;
    
    string public constant name = "Coin Tour";
    
    string public constant symbol = "COT";
    
    uint32 public constant decimals = 8;
    
    function SimpleTokenCoin() {
        balances[forBounty] = 1560000000000000;
        balances[forTeam] = 1000000000000000;
        balances[forFund] = 1000000000000000;
        balances[forLoyalty] = 200000000000000;
    }
    
    function sendETHfromContract() {
        multisig.transfer(this.balance);
    }
    
    function getContractETHBalance() constant returns(uint){
        return this.balance;
    }
    
    function getETHBalance() constant returns(uint){
        return msg.sender.balance;
    }
    
    function multisend(address[] users, uint[] bonus) public onlyOwner {
        for(uint i = 0; i < users.length; i++) {
            transfer(users[i], bonus[i]);
        }
    }
    
}