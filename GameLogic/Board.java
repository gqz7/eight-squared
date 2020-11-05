package com.company;

import java.util.Arrays;

public class Board {

    final static int totalPlaces = 64;
    final static int totalRows = 8;
    final static int totalColumns = 8;

    private BoardPlace[] gameSpace1D;
    private BoardPlace[][] gameSpace2D;

    public Board(Player player1, Player player2) {
        BoardPlace[][][] boardData = initializeBoard( player1, player2 );
        gameSpace1D = boardData[0][0];
        gameSpace2D = boardData[1];

    }

    private BoardPlace[][][] initializeBoard (Player player1, Player player2) {
        BoardPlace[] startingBoard1D = new BoardPlace[totalPlaces];
        BoardPlace[][] startingBoard2D = new BoardPlace[totalRows][totalColumns];

        int count = 0; //count keeps track of the index of the single dimension array
        for (int i = 0; i < totalRows; i++) {
            for (int j = 0; j < totalColumns; j++) {
                //create a new space for pieces to reside
                BoardPlace newSpace = new BoardPlace( i+1, j+1 );
                //create a new pieces based on the location of the space
                Piece newPiece = getSpacesPiece(newSpace);
                //add the piece to the space
                newSpace.holding = newPiece;

                //add newly created Piece to players pieces array
                if (newPiece != null){
                    if (newPiece.isWhite)
                        player1.addPiece(newPiece);
                    else
                        player2.addPiece(newPiece);
                }
                //add space to board arrays
                startingBoard2D[i][j] = newSpace;
                startingBoard1D[count] = newSpace;
                count++;
            }
        }

        return new BoardPlace[][][] { {startingBoard1D}, startingBoard2D};
    }

    private Piece getSpacesPiece(BoardPlace startPos) {
        if (startPos.row > 2 && startPos.row < 7 ) return null;

        if (startPos.row == 2 || startPos.row == 7 ) return new Pawn(startPos);

        switch (startPos.columnInt) {
            case 1:
            case 8:
                return new Rook(startPos);
            case 2:
            case 7:
                return new Knight(startPos);
            case 3:
            case 6:
                return new Bishop(startPos);
            case 4:
                return new Queen(startPos);
            case 5:
                return new King(startPos);
            default:
                System.out.println("An Invalid Position Was Given to 'getSpacePieces' in Board");
                return null;
        }
    }

//    @Override
//    public String toString() {
//
//        String currentGameBoard = "";
//        for (int i = 0; i < gameSpace2D.length; i++) {
//            currentGameBoard += i+1 + "| " + (Arrays.toString(gameSpace2D[i])) + "\n";
//        }
//        currentGameBoard += " | | A | B | C | D | E | F | G | H|";
//        return currentGameBoard;
//    }

    public String displayBoard ( boolean isBlackMoving ) {

        StringBuilder currentGameBoard = new StringBuilder();
        int increaseBy = isBlackMoving ? -1 : 1;

        for (
              int i = isBlackMoving ? totalRows-1 : 0;
              !isBlackMoving && i < gameSpace2D.length || isBlackMoving && i > -1;
              i += increaseBy
        ) {
            currentGameBoard.append(i+1).append("| ").append(Arrays.toString(gameSpace2D[i])).append("|\n");
        }

        currentGameBoard.append("   | A | B | C | D | E | F | G | H |");

        return currentGameBoard.toString();
    }

    public void takeTurn(Turn playersTurn) {
        Piece movingPiece = playersTurn.movingPiece;
        BoardPlace movingSpaceHold = playersTurn.moveTo;

        //update data in the piece that is moving
        BoardPlace oldSpace = movingPiece.position;
        oldSpace.holding = null;
        BoardPlace newSpace = movingPiece.position = movingSpaceHold;

        //update the space that the piece is moving to
        if (movingSpaceHold.holding != null) {
            movingSpaceHold.holding.isInGame = false;
            movingSpaceHold.holding.position = null;
        }
        movingSpaceHold.holding = movingPiece;

        //update the board
        gameSpace2D[oldSpace.row-1][oldSpace.columnInt-1] = oldSpace;
        gameSpace2D[newSpace.row-1][newSpace.columnInt-1] = newSpace;

        gameSpace1D[(oldSpace.row-1)*8 + oldSpace.columnInt-1] = oldSpace;
        gameSpace1D[(newSpace.row-1)*8 + newSpace.columnInt-1] = newSpace;
    }

    public BoardPlace getSpace (int rowInt, int colInt) {
        if ( rowInt < 1 || colInt < 1 || rowInt > 8 || colInt > 8 ) return null;
//        System.out.println("Row: " + rowInt + " Col: " + colInt);
        return gameSpace2D[rowInt-1][colInt-1];
    }

}
