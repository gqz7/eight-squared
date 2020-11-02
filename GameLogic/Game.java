package com.company;

public class Game {

    private Player player1;
    private Player player2;

    private Board gameBoard;

    public Game () {

        player1 = new Player(true);
        player2 = new Player(false);

        gameBoard = new Board(player1, player2);
    }

    public void printCurrentGame () {
        System.out.println(gameBoard);
    }
}
