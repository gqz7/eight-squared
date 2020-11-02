package com.company;

public class Knight extends Piece {

    public Knight (BoardPlace startPos) {
        super(startPos);
    }

    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }

    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "H";
    }
}
