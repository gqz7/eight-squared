package com.company;

public class Bishop extends Piece {

    public Bishop (BoardPlace startPos) {
        super(startPos);
    }

    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "B";
    }

    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }
}