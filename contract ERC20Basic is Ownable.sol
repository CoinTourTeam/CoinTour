contract ERC20Basic is Ownable {
    uint256 public totalSupply;
    function balanceOf(address who) public constant returns (uint256);
    function transfer(address to, uint256 value)public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

/**
* @title ERC20 interface
* @dev https://github.com/ethereum/EIPs/issues/20
*/