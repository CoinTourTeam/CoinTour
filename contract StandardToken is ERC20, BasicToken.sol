contract StandardToken is ERC20, BasicToken {

    mapping (address => mapping (address => uint256)) allowed;
    
    /**
    * @dev Transfers tokens from one address to another.
    * @param _from The address which you want to send tokens from.
    * @param _to The address which you want to transfer to.
    * @param _value The amount of tokens to be transfered.
    */
    function transferFrom(address _from, address _to, uint256 _value) public restrictionOnUse isNotFrozen returns(bool) {
        require(_value <= allowed[_from][msg.sender]);
        var _allowance = allowed[_from][msg.sender];
        balances[_to] = balances[_to].add(_value);
        balances[_from] = balances[_from].sub(_value);
        allowed[_from][msg.sender] = _allowance.sub(_value);
        Transfer(_from, _to, _value);
        return true;
    }
    
    /**
    * @dev Approves the passed address to spend the specified amount of tokens on behalf of msg.sender.
    * @param _spender The address which will spend the funds.
    * @param _value The amount of tokens to be spent.
    */
    function approve(address _spender, uint256 _value) public restrictionOnUse isNotFrozen returns (bool) {
        require((_value > 0)&&(_value <= balances[msg.sender]));
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    /**
    * @dev Function to check the amount of tokens that an owner allowed to a spender.
    * @param _owner The address which owns the funds.
    * @param _spender The address which will spend the funds.
    */
    function allowance(address _owner, address _spender)public constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}

/**
 * @title Mintable token
 * @dev Issue: * https://github.com/OpenZeppelin/zeppelin-solidity/issues/120
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */