pragma solidity =0.5.16;

import '../DurianERC20.sol';

contract ERC20 is PancakeERC20 {
    constructor(uint _totalSupply) public {
        _mint(msg.sender, _totalSupply);
    }
}
