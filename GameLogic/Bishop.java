package com.company;

public class Bishop extends Piece {

    private String name;
    public Bishop (BoardPlace startPos) {
        super(startPos);
        name = "Bishop";

    }

    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "B";
    }

    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }

    @Override
    public String getName() {
        return name;
    }
}
