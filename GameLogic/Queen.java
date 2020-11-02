package com.company;

public class Queen extends Piece {

    public Queen (BoardPlace startPos, boolean isWhite) {
        super(startPos, isWhite);
    }

    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }

    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "Q";
    }
}
