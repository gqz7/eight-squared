# Chess via Processing3

This Chess application was made to play with two human players. 
Players take turns back and forth first selecting a piece, and then their desired move.
This GUI also comes with features of pausing and resigning durring gameplay. 
Information displays show game time (total and per player) as well as whose turn it is (also indicated by board orientation) and the current turn number.

This current implementation allows for pawns to be switched out with Queen or Knight (i didnt feel the need to include any others)
Possible moves take into account the potential for self checking ones king and checkmate is detirmined by there being no possible moves for a player in check.

This application was first created as a CLI application and then the logic was transfered directly to a GUI using Processing3 (3.5.4)
To play you only need to download Processing3 open the 'Chess' folder from this directory and press the play/triangle button. And the game will start up. 
Game play will continue until on of the player is put in checkmate, at that point the game will declare a winner and the game will auto restart.

Feel free to use this code for whatever you'd like. I made this purley as a learning excercise that was fun and enjoyable to create.

## Example
![](../chess-gui-example.gif)

### TODO
    [] implement 'Castle'
    [] implement possible game draw
    [*] complete a check logic
    [*] complete a checkmate logic
    [*] implement check/checkmate logic so  players can not move to a space that will kill them. 
    [*] create UI for game; 
        [*] # of turns, 
        [*] player moving, 
        [*] move & game timer
    [*] add between moves transition
    [*] delay timer count one second if a turn change just occured 
    [*] implement choice of piece if pawn get to other side of the
    [*] add resign button with warning
    [*] when you click a piece a second time it should de-select 