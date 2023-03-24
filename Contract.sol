pragma solidity >=0.5.0 <0.9.0;

contract ZombieFactory {
    
    //TODO: Declare events
    event NewZombie(uint zombieId, string name, uint dna);

    //TODO: Declare state varaibles
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    //TODO: Define a zombie
    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
        
}
