package com.company;

import java.util.Arrays;

public class Board {

    final static int totalPlaces = 64;
    final static int totalRows = 8;
    final static int totalColumns = 8;

    private BoardPlace[] gameSpace;
    private BoardPlace[][] gameSpace2D;

    public Board(Player player1, Player player2) {

        gameSpace = createBoardPlaces1D();
        gameSpace2D = createBoardPlaces2D();

    }

    private BoardPlace[] createBoardPlaces1D() {
        BoardPlace[] startingBoard = new BoardPlace[totalPlaces];

        for (int i = 0; i < totalPlaces; i++) {
            int row = (i/8) + 1;
            int colNum = (i%8) + 1;
//            System.out.println("Row: " + row + " Col: " + colNum);
            startingBoard[i] = new BoardPlace( row, colNum );
        }
        return startingBoard;
    }

    private BoardPlace[][] createBoardPlaces2D() {
        BoardPlace[][] startingBoard = new BoardPlace[totalRows][totalColumns];

        for (int i = 0; i < totalRows; i++) {
            for (int j = 0; j < totalColumns; j++) {
                startingBoard[i][j] = new BoardPlace( i+1, j+1 );
            }
        }
        return startingBoard;
    }

    @Override
    public String toString() {
        String currentGameBoard = "";
        for (int i = 0; i < gameSpace2D.length; i++) {
            currentGameBoard += (Arrays.toString(gameSpace2D[i])) + "\n";
        }
        return currentGameBoard;
    }
}
