package com.company.ChessLogic;

import com.company.CLI;
import com.company.ChessLogic.Enviorment.Board;
import com.company.ChessLogic.Control.Player;
import com.company.ChessLogic.Control.Turn;
import com.company.DesktopActions;

import java.awt.*;

public class Game {

    private final Player player1;
    private final Player player2;

    private final Board gameBoard;

    private int turn;
    private boolean whitesTurn;

    public Game () {

        turn = 1;
        whitesTurn = true;
        player1 = new Player(true, 0, 0);
        player2 = new Player(false,0, 0);

        gameBoard = new Board(player1, player2);

    }

    public Game (int clearBtnX, int clearBtnY) {

        turn = 1;
        whitesTurn = true;
        player1 = new Player(true, clearBtnX, clearBtnY);
        player2 = new Player(false, clearBtnX, clearBtnY);

        gameBoard = new Board(player1, player2);
    }


    public void gameStart() {
        boolean gameEnded = false;

        while (!gameEnded) {

            Turn playersTurn;
            if (whitesTurn)
                playersTurn = player1.makeTurn(gameBoard, turn);
            else
                playersTurn = player2.makeTurn(gameBoard, turn);

            gameBoard.takeTurn(playersTurn);

            whitesTurn = !whitesTurn;
            turn++;
        }
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
