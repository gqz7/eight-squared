package com.company;

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
}
