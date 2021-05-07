pragma solidity =0.5.16;

import '../DurianERC20.sol';

contract ERC20 is DurianERC20 {
    constructor(uint _totalSupply) public {
        _mint(msg.sender, _totalSupply);
    }
}
