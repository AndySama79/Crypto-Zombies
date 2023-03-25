// SPDX-License-Identifier: GPL 3.0
pragma solidity ^0.8.0;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {
    
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);  // require we own this zombie
        Zombie storage myZombie = zombies[_zombieId];

        // newDna = avg(_targetDna and myZombie.dna)
        // make sure that _targetDna is not longer than 16 digits
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);    // it's correct
    }
}