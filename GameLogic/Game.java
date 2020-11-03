package com.company;

public class Game {

    private Player player1;
    private Player player2;

    private Board gameBoard;

    private int turn;
    private boolean whitesTurn;

    public Game () {

        turn = 0;
        whitesTurn = true;
        player1 = new Player(true);
        player2 = new Player(false);

        gameBoard = new Board(player1, player2);

        gameStart();
    }

    private void gameStart() {
        boolean gameEnded = false;
        while (!gameEnded) {
            System.out.println("It's your turn " + (whitesTurn ? "white" : "black") + "!");
            Turn playersTurn;
            if (whitesTurn)
                playersTurn = player1.makeTurn();
            else
                playersTurn = player2.makeTurn();

            gameBoard.takeTurn(playersTurn);

            whitesTurn = !whitesTurn;
        }
    }

    public void printCurrentGame () {
        System.out.println("\n________________________\n");
        System.out.println("TURN: " + turn + "\n");
        System.out.println(gameBoard);
        System.out.println("________________________\n");
    }

    public void printPlayerPieces () {
        System.out.println("\nPLAYERS PIECES\n");
        System.out.println("\n________________________\n");
        System.out.println("PLAYER ONE:\n");
        System.out.println(player1);
        System.out.println("\n________________________\n");
        System.out.println("PLAYER TWO:\n");
        System.out.println(player2);

    }
}
