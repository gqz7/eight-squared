package com.company;

public class Knight extends Piece {

    private String name;
    public Knight (BoardPlace startPos) {
        super(startPos);
        name = "Knight";

    }

    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }

    @Override
    public BoardPlace[] getPossibleMoves( Board board ) {
        return new BoardPlace[0];
    }

    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "H";
    }

    @Override
    public String getName() {
        return name;
    }
}
