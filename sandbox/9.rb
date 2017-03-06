Rounds 6+ Research
__________________

63 - 64 > 79 - 80
- r4 - O blocks at edge
- r5 - X blocks at edge
- r6 - O should take an open edge for a chance to win  
- r7 - X blocks at edge
- r8 - O blocks at corner
- r9 - X takes last open position  

X O X   - - X
- O -   X O O
- X -   - - X
__________________

65 - 66 > 81 - 82
- r4 - O blocks at corner
- r5 - X blocks at corner
- r6 - O blocks at edge  
- r7 - X blocks at edge
- r8 - O takes random position  
- r9 - X takes last open position  

X X O   X - X
- O -   - O X
X - -   - - O
__________________

67 - 68 > 83 - 84

- r4 - O takes edge opposite corner X
- r5 - X blocks at edge
- r6 - O blocks at corner  
- r7 - X blocks at corner
- r8 - O blocks at edge
- r9 - X takes last open position  

X - -   X X -
X O O   - O X
- X -   - O -
__________________

69 - 70 > 85 - 86

- r4 - O blocks at corner
- r5 - X blocks at edge
- r6 - O blocks at edge  
- r7 - X should take either open edge for a chance to win  
- r8 - O blocks at edge
- r9 - X takes last open position  

O - X   O X O
X X -   - X -
O - -   - - X
__________________

71 - 72 > 87 - 88
*** same board layout as 85 - 86 at r7

- r4 - O takes a corner
- r5 - X blocks at edge
- r6+ - O should use win/block logic  
- r7 - X should take either open edge for a chance to win  
- r8 - O blocks at edge
- r9 - X takes last open position  

O - -   - - X
X X -   - X -
O - X   O X O
__________________

73 - 74 > 89 - 90

O - -   O X -
X X O   - X -  > 73 r5 - X (t2), 75 r5 - X (m1)
- - -   - O -

["O", "", "", "X", "X", "O", "", "", ""]
["O", "X", "", "", "X", "", "", "O", ""]

- r4 - O blocks at edge
- r5 - X takes open edge next to corner O  *** need to add X logic for round 5 (if no block/win)  
- r6 - O blocks at edge - win/block logic  
- r7 - X takes an open corner  *** need to add X logic for round 7 (if no block/win)  
- r8 - O blocks at corner
- r9 - X takes last open position  

O X -   O X -
X X O   X X -
- - -   - O -

73 mock game:
t2 - ideal, X needs logic to take either corner in round 7 and last position in round 9
t3 - ideal, X needs logic to take either edge in round 7 and last position in round 9
b1 - sets O up for a chance to win in round 8
b2 - sets O up for a chance to win in round 8
b3 - potential to give O a chance to win in round 8

O - -
X X O
- - -
__________________

75 - 76 > 91 - 92

- r4 - O takes a random corner, chance to win
- r5 - X blocks at corner, chance to win
- r6 - O blocks at corner, chance to win - win/block logic
- r7 - X blocks at edge, tie game
- r8 - O takes random open position  
- r9 - X takes last open position  

O X -   X - -
- O -   X O X
- X X   - - O
__________________

77 - 78 > 93 - 94

- r4 - O takes corner between X edges
- r5 - X blocks at corner
- r6 - O takes either corner  
- r7 - X blocks at corner
- r8 - O blocks at edge
- r9 - X takes last open position  

- X O   X - -
- O X   - O X
X - -   - X O

* Research for corner selection - one less chance of X win if O takes central corner:

77
r4 - O takes middle corner (t3), O chance to win
r5 - X blocks at corner (b1)
r6 - O takes either corner (t1/b3), O chance to win
r7 - X blocks at opposite corner (t1/b3), X chance to win
r8 - O blocks at edge (m1), tie game
r9 - X takes open edge (b2)

X X O
- O X
X - O

78
r4 - O takes adjacent corner (b1), O chance to win
r5 - X blocks at corner (t3), X chance to win
r6 - O blocks at corner (b3), O chance to win
r7 - X blocks at corner (t1), X chance to win
r8 - O blocks at edge (t2), tie game
r9 - X takes open edge (m1)

X - X
- O X
O X O
__________________