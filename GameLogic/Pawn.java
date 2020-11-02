package com.company;

public class Pawn extends Piece {
    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }
}
