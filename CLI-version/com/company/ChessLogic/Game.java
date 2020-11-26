package com.company.ChessLogic;

import com.company.ChessLogic.Enviorment.Board;
import com.company.ChessLogic.Control.Player;
import com.company.ChessLogic.Control.Turn;

public class Game {

    private Player player1;
    private Player player2;

    private Board gameBoard;

    private int turn;
    private boolean whitesTurn;

    public Game () {

        turn = 1;
        whitesTurn = true;
        player1 = new Player(true);
        player2 = new Player(false);

        gameBoard = new Board(player1, player2);

        gameStart();
    }

    private void gameStart() {
        boolean gameEnded = false;
        while (!gameEnded) {
            printCurrentGame();
            Turn playersTurn;
            if (whitesTurn)
                playersTurn = player1.makeTurn(gameBoard);
            else
                playersTurn = player2.makeTurn(gameBoard);

            gameBoard.takeTurn(playersTurn);

            whitesTurn = !whitesTurn;
            turn++;
        }
    }

    public void printCurrentGame () {
        System.out.println("\n________________________________________________\n");
        System.out.println("TURN: " + turn + "\t\tMOVING: " + (whitesTurn ? "WHITE" : "BLACK") +"\n");
        System.out.println(gameBoard.displayBoard(whitesTurn));
        System.out.println("________________________________________________\n");
    }

    public void printPlayerPieces () {
        System.out.println("\nPLAYERS PIECES\n");
        System.out.println("\n________________________________________________\n");
        System.out.println("PLAYER ONE:\n");
        System.out.println(player1);
        System.out.println("\n________________________________________________\n");
        System.out.println("PLAYER TWO:\n");
        System.out.println(player2);

    }
}
