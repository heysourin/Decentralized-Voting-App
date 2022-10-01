//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "../node_modules/hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Create {
    //This is the way we use plugins in our smart contracts.useing 'contract-name' for 'function-we-want-to-use'
    // make sure you use the same name;
    using Counters for Counters.Counter;

    Counters.Counter public _voterId;
    Counters.Counter public _candidateId;

    address public votingOrganizer;

    //Todo:
    //---- Candidate for the vote ----
    struct Candidate {
        uint candidateId;
        string age;
        string name;
        string image; //From IPFS we are going to add the image
        uint voteCount;
        address _address;
        string ipfs; //IPFS going to contain all the informations about the candidate, we will upload the entire data to the ipfs and fetch and add as an url. Anyone wants to know more about the candidate they can go to the link and learn about the canditate along with all details.7
    }

    event CandidateCreate(
        uint indexed candidateId,
        string age,
        string name,
        string image,
        uint voteCount,
        address _address,
        string ipfs
    );

    address[] public candidateAddress;

    mapping(address => Candidate) public candidates;

    //---End of candidate data---

    // ---- VOTER DATA ----
    address[] public votedVoters;
    address[] public votersAddress;

    struct Voter {
        uint voter_voterId;
        string voter_name;
        string voter_image;
        address voter_address;
        uint voter_allowed;
        bool voter_voted;
        uint voter_vote;
        string voter_ipfs;
    }
    mapping(address => Voter) public voters;

    event VoterCreate(
        uint voter_voterId,
        string voter_name,
        string voter_image,
        address voter_address,
        uint voter_allowed,
        bool voter_voted,
        uint voter_vote,
        string voter_ipfs
    );
     
    //----End of voter data----

    constructor(){
        votingOrganizer = msg.sender;
    }

    function setCandidate(address _address, string memory _age, string memory _name, string memory _image, string memory _ipfs) public{
        require(votingOrganizer == msg.sender,"Only organizer can create candidature");

        _candidateId.increment();//calling this function from 'counter.sol'

        uint idNumber = _candidateId.current();

        Candidate storage candidate = candidates[_address];//assigning the mapping using struct

        candidate.age = _age;
        candidate.name = _name;
        candidate.candidateId = idNumber;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate._address = _address;
        candidate.ipfs = _ipfs;

        candidateAddress.push(_address);

        emit CandidateCreate(idNumber, _age, _name, _image, candidate.voteCount, _address, _ipfs);
    }
}
