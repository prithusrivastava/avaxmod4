// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CandyCrushGame is ERC20, Ownable {

    uint public constant InitialLives = 3;
    mapping(address => uint) private playerLives;
    
    constructor() 
        ERC20("CandyCrushGame", "CCG") 
        Ownable(msg.sender) 
    {
        _mint(msg.sender, InitialLives);
        playerLives[msg.sender] = InitialLives;
    }

    function mintCandy(address account, uint amount) public onlyOwner {
        _mint(account, amount);
    }

    function matchCandies(uint amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough candies");
        _burn(msg.sender, amount);
    }

    function playerMiss() public {
        require(playerLives[msg.sender] > 0, "No lives left");
        playerLives[msg.sender]--;
    }

    function getPlayerLives(address player) public view returns (uint) {
        return playerLives[player];
    }
}

