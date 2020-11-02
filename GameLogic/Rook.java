package com.company;

public class Rook extends Piece {
    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }
}
