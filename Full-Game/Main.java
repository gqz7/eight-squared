package com.company;

import com.company.Chess.Logic.Game;

public class Main {

    public static void main(String[] args) {

        var chessGame = new Game();

        chessGame.printPlayerPieces();
        chessGame.printCurrentGame();

    }
}
