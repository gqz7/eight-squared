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
        int tempCol = piecePos.columnInt;

        BoardPlace oneSpaceForward = board.getSpace( tempRow + (isWhite ? 1 : -1), tempCol );

        BoardPlace twoSpaceForward = board.getSpace( tempRow + (isWhite ? 2 : -2), tempCol );

        BoardPlace diagonalLeft = board.getSpace(tempRow + (isWhite ? 1 : -1), tempCol + (isWhite ? 1 : -1));

        BoardPlace diagonalRight = board.getSpace(tempRow + (isWhite ? 1 : -1), tempCol + (isWhite ? -1 : 1));

        if ( oneSpaceForward != null && oneSpaceForward.isEmpty() )
            movesList.add( oneSpaceForward );
        if ( tempRow == 2 && isWhite || tempRow == 7 && !isWhite) {
            if (  twoSpaceForward != null && twoSpaceForward.isEmpty() )
                movesList.add( twoSpaceForward );
        }
        if (
                diagonalLeft != null
                        && !diagonalLeft.isEmpty()
                        && diagonalLeft.hasEnemy( isWhite )
        ) {
            movesList.add(diagonalLeft);
        }
        if (
                diagonalRight != null
                        && !diagonalRight.isEmpty()
                        && diagonalRight.hasEnemy( isWhite )
        ) {
            movesList.add(diagonalRight);
        }
        return movesList.toArray( new BoardPlace[0]); //movesList.size()
    }
}
