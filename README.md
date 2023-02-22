## Introduction:
Designing an electronic Roulette game using a DE2 board, a digital circuit board used for learning 
digital logic design.

### Roulette Game: 
Simple game played in Casinos worldwide. The player makes a number of bets, and a
large wheel is spun, resulting in one winning number.
This project focuses on european version of the game, which has 37 possible outcomes, with no 00
on the wheel. In this project we are only considering three types of bet.



<p align="center">
  <img src="/gamePreview.png">
</p>

### Bet 1 (Straight up bet): 
This involves the player betting on a single number from 0 to 36. The payoff 
from this type of bet is 35:1, meaning that if the player bets $10 in a straight-up bet and wins, 
the player gets $350 back plus the original $10

### Bet 2 (Colour Bet): 
This allows the player to bet on whether a red or black number will come up. The 
payoff from this type of bet is 1:1, meaning that if the player bets $10 and correctly predicts 
the color of the winning number, he or she will receive a payout of $10 plus the original $10 bet.

### Bet 3 (Dozen Bet): 
This allows the player to bet that the winning number will be in one of the following
ranges: [1,12], [13,24], or [25,36]. If the player is right, the payoff for this kind of bet is 2:1,
meaning that if the player bets $10 and predicts the correct dozen, he or she will receive a payout
of $20 plus the original $10 bet.

## Rules for betting: 
1. Only the three previously-mentioned types of bets will be considered, and the user will make
exactly three bets: bet #1 will always be a straight-up bet, bet #2 will always be a color bet, 
and bet #3 will always be a dozen bet.
2. The maximum amount that can be bet for each of the three bets is $7, and the minimum bet is $0.
3. All inputs of the circuit will be in binary, and all outputs will be in base-16 (convert to base 10 if possible).
4. The player starts out with $32.

## FPGA (DE2) functionality: 

The user places the following quantities on the switches:
### Bet 0: 
       Amount to bet ($0-$7): Switches 2-0
       Number to bet on (0-36): Switches 8-3
### Bet 1: 
       Amount to bet ($0-$7): Switches 9-11
       Colour to bet on (0-1): Switch 12 [red=1, black=0]
### Bet 2: 
       Amount to bet ($0-$7): Switches 15-13
       Dozen to bet on (0,1 or 2): Switches 17-16
       
<p align="center">  <img src="/datapath.png"> </p> 

       
