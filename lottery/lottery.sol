pragma solidity ^0.4.16;

contract Lottery {
    address owner;
    Draw currentDraw;
    mapping (uint => Draw) drawHistory;

    struct Entrant {
        address addr;
        uint amount;
    }

    struct Draw {
        uint drawNumber;
        uint jackpot;
        uint sold;
        uint entrantsCount;
        mapping (address => Entrant) entrants;
    }

    function Lottery() public {
        owner = msg.sender;
        currentDraw = Draw({drawNumber: 1, jackpot: 10, sold: 0, entrantsCount: 0});
    }

    function drawDetails(uint drawNumber) public constant returns (
        uint _drawNumber,
        uint _jackpot,
        uint _sold,
        uint _entrants
    ) {
        Draw memory d;
        if (drawNumber == 0) {
            d = currentDraw;
        } else {
            if (currentDraw.drawNumber == drawNumber) {
                d = currentDraw;
            } else {
                d = drawHistory[drawNumber];
            }
        } 
        _drawNumber = d.drawNumber;
        _jackpot = d.jackpot;
        _sold = d.sold;
        _entrants = d.entrantsCount;
    }

    function whoAmI() public constant returns(string _youAre, address _addy) {
        if (owner == msg.sender) {
            _youAre = "the owner";   
        } else {
            _youAre = "not the owner";  
        }
        _addy = msg.sender;
    }

    function ticket(uint amount, uint difficulty) pure private returns(string) {
        return "TODO";
    }

    function enter(address agent) payable public {
        address agentAddress;
        if(agent == address(0)) {
            agentAddress = owner;
        } else {
            agentAddress = agent;
        }

        if(currentDraw.entrants[msg.sender].amount > 0) {
            currentDraw.entrants[msg.sender].amount+=msg.value;
        } else {
            currentDraw.entrants[msg.sender] = Entrant({addr: msg.sender, amount: msg.value});
            currentDraw.entrantsCount+=1;
        }
        currentDraw.sold += msg.value;
    }
}