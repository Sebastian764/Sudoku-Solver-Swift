# Sudoku Solver Swift

This is an iOS/iPadOS app that generates 9x9 sudoku boards that a user can interact with, and also adds some basic functionality on top of it, like ignoring any numbers other than 1-9.

The app starts off in this screen:

<img width="400" alt="Screenshot 2023-08-31 at 11 34 55 AM" src="https://github.com/Sebastian764/Sudoku-Solver-Swift/assets/120810193/945ce33f-e3f1-4e1a-a08e-dd213db83abc">



**It will generate an empty board, and the user can then select from 3 options below:**

If the user wants to generate a random board, they can tap "Randomize", which will clear the current board and generate a brand new board with randomized values.
<img width="400" alt="Screenshot 2023-08-31 at 11 34 55 AM" src="https://github.com/Sebastian764/Sudoku-Solver-Swift/assets/120810193/5b78530b-d0a0-4483-8d90-5010c89dd9d5">



The user can also ask for a hint on their currrent board. The app will fill out the next available square, or will tell the user if the board is unsolvable.
<img width="400" alt="Screenshot 2023-08-31 at 11 34 55 AM" src="https://github.com/Sebastian764/Sudoku-Solver-Swift/assets/120810193/9dcd7041-7236-4b17-9a33-26adb6f14ad2">



Finally, the user can also ask the app to solve the board. If the board is solvable, the values will be filled in. If it is not solvable, it will alert the user and it will not touch the board.
<img width="400" alt="Screenshot 2023-08-31 at 11 34 55 AM" src="https://github.com/Sebastian764/Sudoku-Solver-Swift/assets/120810193/aed2b759-47b3-4e49-ab3f-0532bfa88bf1">


Note: I added the camera manager for future expansion, but it is currently unused.


