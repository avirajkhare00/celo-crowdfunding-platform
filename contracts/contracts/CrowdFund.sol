// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CrowdFund {

    struct Cause {
        string name;
        string description;
        string ipfsHash;
        uint256 target;
        uint256 raised;
        address payable wallet;
    }

    event NewCauseLog(string name, string description, string ipfsHash, uint256 target, uint256 raised, address indexed wallet);
    event CauseFundLog(string name, string description, string ipfsHash, uint256 target, uint256 raised, address indexed wallet);

    Cause[] private causes;

    function createCause(string memory _name, string memory _description, string memory _ipfsHash, uint256 _target) public {
        causes.push(Cause(_name, _description, _ipfsHash, _target, 0, payable(msg.sender)));
        emit NewCauseLog(_name, _description, _ipfsHash, _target, 0, msg.sender);
    }

    function totalCauses() public view returns(uint) {
        return causes.length;
    }

    function causeById(uint _id) public view returns(string memory, string memory, string memory, uint256, uint256) {
        return (causes[_id].name, causes[_id].description, causes[_id].ipfsHash, causes[_id].target, causes[_id].raised);
    }

    function fundCauseById(uint _id) public payable {
        require(msg.value > 0, "CELO amount must be greater then 0");
        require(msg.value <= causes[_id].target, "CELO amount must be less then target amount");
        require(causes[_id].raised <= causes[_id].target, "This cause is funded");
        causes[_id].raised += msg.value;
        (bool sent, bytes memory data) = causes[_id].wallet.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        emit CauseFundLog(causes[_id].name, causes[_id].description, causes[_id].ipfsHash, causes[_id].target, causes[_id].raised, causes[_id].wallet);
    }

}