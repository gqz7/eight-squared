# eight²

This is a Chess project I built from scratch. I used this as an opportunity to learn more about chess and treated each piece as an algorithmic challange and a way to become more familiar with OOP concepts.

This started with a Command-Line application where piece where selected and moved using number inputs from the terminal. Then using processing I was able to use almost all the same code just by adding a GUI and integrating the pre-existing logic. I made many updates after switching to a GUI so the CLI version is not as fleshed out as the GUI version. I would like to take the code from the GUI version and implement it into the CLI so things like check and checkmate are a part of the CLI.

# GUI 
![](chess-gui-example.gif)

# CLI 
![](chess-cli-example.gif)

### TODO
    [*] complete a check logic
    [*] complete a checkmate logic
    [] complete a draw logic
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
