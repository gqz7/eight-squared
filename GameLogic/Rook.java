package com.company;

public class Rook extends Piece {
    private String name;
    public Rook (BoardPlace startPos) {
        super(startPos);
        name = "Rook";
    }
    @Override
    public Turn move(BoardPlace moving) {
        return new Turn(this, moving);
    }

    @Override
    public BoardPlace[] getPossibleMoves( Board board) {
        return new BoardPlace[0];
    }

    @Override
    public String toString() {
        return (this.isWhite ? "W" : "B") + "R";
    }

    @Override
    public String getName() {
        return name;
    }
}
