Round 6
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
- r6+ - O should use win/block logic
*** if no win/block, should take random open position to keep game moving (i.e. round 8)  

X X O   X - X
- O -   - O X
X - -   - - O
__________________

67 - 68 > 83 - 84  *** need to fix 67 - 68  

- r4 - O takes non-opposite edge  *** need to fix - should be "O takes edge opposite corner X"  
- r5 - X blocks at edge
- r6+ - O should use win/block logic

* 67 - r4 - O should take m3

X - -
- O O
- X -

* 68 - r4 - O should take b2

X - -
- O X
- O -

Logic to select edge:
1) Determine opponent edge & corner positions - (edges & opponent) and (corners & opponent)
2) Find index of sides that do not contain corner X
3) Find adjedg pair that corresponds to those sides * do NOT change @adjedg array order
4) Edge will be (adjedg - opponent)

@adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]
__________________

69 - 70 > 85 - 86

- r4 - O blocks at corner
- r5 - X blocks at edge
- r6+ - O should use win/block logic
*** r7 - X should take an open edge for a chance to win  
- r8 - O blocks
- r9 - X takes last open position

O - X   O X O
X X -   - X -
O - -   - - X
__________________

71 - 72 > 87 - 88
*** r7 turns into same board layout as 85 - 86

- r4 - O takes a corner
- r5 - X blocks at edge
- r6+ - O should use win/block logic
*** r7 - X should take an open edge for a chance to win  
- r8 - O blocks
- r9 - X takes last open position

O - -   - - X
- X -   - X -
- - X   O - -

t3*
b1

O - -   - - X
X X O   - X -
O - X   O - -
__________________

73 - 74 > 89 - 90

- r4 - O blocks at edge
- r5 - X takes edge next to corner O  *** need to add X logic for round 5 (if no block/win)
- r6 - O blocks at edge
- r7 - X takes an open corner  *** need to add X logic for round 7 (if no block/win)
- r8 - O blocks at corner
- r9 - X takes last corner

O X -   O X -
X X O   X X -  > change board layout for 90 - better to have "mirror" version for testing
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
- r6 - O blocks at corner, chance to win
- r7 - X blocks at edge, tie game
- r8 - O takes random open position
- r9 - X takes last open position

O X -   X - -
- O -   X O X
- X X   - - O
__________________

77 - 78 > 93 - 94  *** need to fix 77 - 78  

- r4 - O takes random adjacent corner > change to: should be O takes corner between X edges
      *** need to change logic, one less chance of X win if O takes central corner
- r5 - X blocks at corner
- r6 - O takes random corner
- r7 - X blocks at corner
- r8 - O blocks at edge
- r9 - X takes last open position

- X -   - - -
- O X   - O X
- - -   - X -

- X O   - - X
- O X   - O X
X - -   O X -

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