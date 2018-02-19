contract BurnableToken is MintableToken {
  using SafeMath for uint;
  /**
   * @dev Burns a specific amount of tokens.
   * @param _value The amount of token to be burned.
   */
  function burn(uint _value) restrictionOnUse() public {
    require(_value > 0);
    address burner = msg.sender;
    balances[burner] = balances[burner].sub(_value);
    totalSupply = totalSupply.sub(_value);
    Burn(burner, _value);
  }
 
 function burnFrom(address _from, uint _value) restrictionOnUse() public returns (bool success) {
    require(balances[_from] > _value);               // Check if the sender has enough
    require(_value <= allowed[_from][msg.sender]);   // Check allowance
    balances[_from] = balances[_from].sub(_value);                          // Subtract from the sender
    Burn(_from, _value);
    return true;
}

  event Burn(address indexed burner, uint indexed value);
 
}