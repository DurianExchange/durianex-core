pragma solidity =0.5.16;

/*
 * DurianExchange
 * App:             https://durian.exchange
 * Medium:          https://durianexchange.medium.com
 * Twitter:         https://twitter.com/DurianExchange
 * Announcements:   https://blog.durian.exchange
 * GitHub:          https://github.com/DurianExchange
 */

import './interfaces/IDurianFactory.sol';
import './DurianPair.sol';

contract DurianFactory is IDurianFactory {
    bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(DurianPair).creationCode));

    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, 'Durian: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'Durian: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'Durian: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(DurianPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IDurianPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, 'Durian: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, 'Durian: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
