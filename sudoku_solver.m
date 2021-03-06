clc; clear;

%Input your sudoku here
puzzle = [...
         0 0 6 0 0 8 5 0 0;...
         0 0 0 0 7 0 6 1 3;...
         0 0 0 0 0 0 0 0 9;...
         0 0 0 0 9 0 0 0 1;...
         0 0 1 0 0 0 8 0 0;...
         4 0 0 5 3 0 0 0 0;...
         1 0 7 0 5 3 0 0 0;...
         0 5 0 0 6 4 0 0 0;...
         3 0 0 1 0 0 0 6 0];
 
 %Candidates is a tensor that will hold all the possible candidates for a
 %device.
 candidates = zeros(9,9,9);
 [candidates, puzzle2, breaker] = solve_puzzle(puzzle,candidates);

 %puzzle2 - puzzle
 