package com.company;

public class Bishop extends Piece {
    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }
}
