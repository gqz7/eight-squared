package com.company;

import java.util.ArrayList;
import java.util.List;

public class Pawn extends Piece {

    private String name;
    public Pawn (BoardPlace startPos) {
        super(startPos);
        name = "Pawn";

    }

    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }



    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "P";
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public BoardPlace[] getPossibleMoves( Board board) {

        Piece movingPiece = this;

        List<BoardPlace> movesList = new ArrayList<>();
        boolean isWhite = movingPiece.isWhite;
        BoardPlace piecePos = movingPiece.position;

        int tempRow = piecePos.row;
        //int tempCol = piecePos.columnInt;

        BoardPlace oneSpaceForward = piecePos.getTranslatedSpace(0, 1);
        BoardPlace twoSpaceForward = piecePos.getTranslatedSpace(0, 2);
        BoardPlace diagonalRight = piecePos.getTranslatedSpace(1, 1);
        BoardPlace diagonalLeft = piecePos.getTranslatedSpace(-1, 1);

        if ( tempRow == 2 && isWhite || tempRow == 7 && !isWhite) {
            if ( oneSpaceForward.isEmpty() )
                movesList.add( oneSpaceForward );
            if ( twoSpaceForward.isEmpty() )
                movesList.add( twoSpaceForward );
        } else if ( oneSpaceForward.isEmpty() ) {
            movesList.add( oneSpaceForward );
        }
        if (
           !diagonalRight.isEmpty()
           && diagonalRight.hasEnemy( isWhite )
        ) {
            movesList.add(diagonalRight);
        }
        if (
            !diagonalLeft.isEmpty()
            && diagonalLeft.hasEnemy( isWhite )
        ) {
            movesList.add(diagonalLeft);
        }
        return movesList.toArray( new BoardPlace[0]); //movesList.size()
    }
}
