package com.company;

import com.company.ChessLogic.Game;
import com.company.ChessLogic.GameConfigure;

public class Main {

    public static void main(String[] args) {

        GameConfigure.welcomeMessage();

        Game chessGame = GameConfigure.createGame();

        chessGame.gameStart();

    }
}
