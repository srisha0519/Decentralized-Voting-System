# Decentralized Voting System

## Overview
A blockchain-based voting application developed using Solidity and tested in Remix IDE. It records votes through smart-contract transactions and prevents registered voters from voting more than once.

## Features
- Owner-controlled candidate registration
- Voter registration
- Registration closure before voting
- One vote per registered address
- Vote counting for each candidate
- Ability to start and end voting
- Publicly readable candidate results

## Technology Stack
- Solidity
- Remix Ethereum IDE
- Remix VM (local blockchain simulation)

## How It Works
1. The contract owner deploys the smart contract.
2. The owner adds candidates.
3. Voters register their blockchain addresses.
4. The owner closes registration and starts voting.
5. Registered voters cast one vote each.
6. The owner ends voting, and candidate vote counts can be checked.

## Testing
The contract was compiled, deployed, and tested in Remix VM. Candidate registration, voter registration, voting, and vote counting were verified using simulated blockchain accounts.

## Disclaimer
This is an educational prototype tested on a simulated blockchain. It is not a production-ready election system and has not been audited for security.

## Author
Srisha Reddie