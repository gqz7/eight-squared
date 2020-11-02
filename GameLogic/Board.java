package com.company;

import java.util.Arrays;

public class Board {

    final static int totalPlaces = 64;

    private BoardPlace[] coordinates;

    public Board () {

        coordinates = createBoardPlaces();

        System.out.println(Arrays.toString(coordinates));
    }

    private BoardPlace[] createBoardPlaces() {
        BoardPlace[] startingBoard = new BoardPlace[totalPlaces];

        for (int i = 0; i < totalPlaces; i++) {
            int row = (i/8) + 1;
            int colNum = (i%8) + 1;
//            System.out.println("Row: " + row + " Col: " + colNum);
            startingBoard[i] = new BoardPlace( row, colNum );
        }
        return startingBoard;
    }


}
