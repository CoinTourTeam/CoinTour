contract Crowdsale is SimpleTokenCoin {
    
    using SafeMath for uint;
    
    uint public startPreICO;
    
    uint public startICO;
    
    uint public periodPreICO;
    
    uint public periodsOfICO;

    uint public hardcap;

    uint public rate;
    
    uint public softcap;
    
    mapping(address => uint) ethBalance;
    
    struct BonusSystem {
      // UNIX timestamp of period start
      uint start;
      // UNIX timestamp of period finish
      uint end;
      // How many % tokens will add
      uint bonus;
    }
    
    BonusSystem[] public bonus;
    
    function Crowdsale() public{
      rate = 1600000000000;
      startPreICO = 1515582300;
      periodPreICO = 10;
      startICO = 1517311800;
      periodsOfICO = 10;
      hardcap = 10000000000000000000000;
      softcap = 400000000000000000000;
      setBonusSystem();
    }

    modifier saleIsOn() {
      require((now >= startPreICO && now <= startPreICO + periodPreICO * 1 days)||(now >= startICO && now <= startICO + periodsOfICO * 3 * 1 days));
      _;
    }
	
    modifier isUnderHardCap() {
      require(multisig.balance <= hardcap);
      _;
    }

    function setBonusSystem() private {
        bonus.push(BonusSystem(startPreICO, startPreICO+periodPreICO*1 days, 25));
        bonus.push(BonusSystem(startICO, startICO+periodsOfICO*1 days, 15));
        bonus.push(BonusSystem(startICO+periodsOfICO*1 days, startICO+periodsOfICO*2*1 days, 10));
        bonus.push(BonusSystem(startICO+periodsOfICO*2*1 days, startICO+periodsOfICO*3*1 days, 5));
    }
    
    function getCurrentBonusSystem() public constant returns (BonusSystem) {
      for (uint i = 0; i < bonus.length; i++) {
        if (bonus[i].start <= now && bonus[i].end > now) {
          return bonus[i];
        }
      }
    }

    function refund() {
      require(this.balance < softcap && now > startICO + periodsOfICO * 3 * 1 days);
      uint value = ethBalance[msg.sender]; 
      balances[msg.sender] = 0; 
      msg.sender.transfer(value.div(rate).mul(1 ether)); 
    }

    function createTokens() isUnderHardCap saleIsOn payable {
       multisig.transfer(msg.value);
       if(msg.value >= 10 finney) {
           uint tokens = rate.mul(msg.value).div(1 ether);
           uint bonusTokens = tokens / 100 * getCurrentBonusSystem().bonus;
           tokens += bonusTokens;
           mint(msg.sender, tokens);
           ethBalance[msg.sender] = ethBalance[msg.sender].add(msg.value);
       }
   }

    function() external payable {
      createTokens();
    }
    
}