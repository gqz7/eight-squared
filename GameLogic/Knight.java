package com.company;

public class Knight extends Piece {

    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }
}
