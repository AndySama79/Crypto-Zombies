// SPDX-License-Identifier: GPL 3.0
pragma solidity >=0.5.0 <0.9.0;

import "./Ownable.sol";

contract ZombieFactory is Ownable{
    
    //TODO: Declare events
    event NewZombie(uint zombieId, string name, uint dna);

    //TODO: Declare state varaibles
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    //TODO: Define a zombie
    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    mapping(uint => address) public zombieToOwner; // maps a zombieId to owner address
    mapping(address => uint) ownerZombieCount;  // keeps count of number of zombies belonging to the same owner

    function _createZombie(string memory _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;    // this is correct
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
        
}