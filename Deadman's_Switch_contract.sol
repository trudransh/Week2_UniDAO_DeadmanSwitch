//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract week_2{
    address public owner;
    address[3] benefeciaries;
    bool fundsdistributed;
    uint private lastcheckinblock;
    modifier only_owner(){
        require(msg.sender== owner, "Only owner can call this function");
        _;
    }
    constructor( address[3] memory _benefeciaries) {
        owner = msg.sender;
        lastcheckinblock = block.number;
        benefeciaries = _benefeciaries;
    }

    function still_alive() external only_owner{
        lastcheckinblock = block.number;
    }


    function distributefunds() external {
        require(!fundsdistributed, "funds have already been distributed");
        require(block.number - lastcheckinblock >= 3, "Owner has called the function recently");

        uint256 amountperbenefeciaries = address(this).balance / 10 ;

        for(uint i = 0 ; i < 3 ; i++){
            payable(benefeciaries[i]).transfer(amountperbenefeciaries);
        }
    }

    receive() external payable {}
    fallback() external payable {}
}