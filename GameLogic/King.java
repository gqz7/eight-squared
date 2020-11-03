package com.company;

public class King extends Piece {


    private String name;
    public King (BoardPlace startPos) {
        super(startPos);
        name = "King";

    }
    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }

    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "K";
    }

    @Override
    public String getName() {
        return name;
    }
}
