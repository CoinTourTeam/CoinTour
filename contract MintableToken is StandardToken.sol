contract MintableToken is StandardToken {
    
    event Mint(address indexed to, uint256 amount);
    
    event MintFinished();

    bool public mintingFinished = false;
    
    /**
    * @dev Throws if called when minting is finished.
    */
    modifier canMint() {
        require(!mintingFinished);
        _;
    }
    
    /**
    * @dev Function to mint tokens
    * @param _to The address that will recieve the minted tokens.
    * @param _amount The amount of tokens to mint.
    */
    function mint(address _to, uint256 _amount) internal canMint returns (bool) {
        totalSupply = totalSupply.add(_amount);
        balances[_to] = balances[_to].add(_amount);
        Mint(_to, _amount);
        return true;
    }
    
    /**
    * @dev Function to stop minting new tokens.
    */
    function finishMinting() public onlyOwner returns (bool) {
        mintingFinished = !mintingFinished;
        MintFinished();
        return true;
    }
}

/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */