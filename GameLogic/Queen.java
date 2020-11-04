package com.company;

public class Queen extends Piece {

    private String name;
    public Queen (BoardPlace startPos) {
        super(startPos);
        name = "Queen";
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
        return (this.isWhite ? "W" : "B") + "Q";
    }

    @Override
    public String getName() {
        return name;
    }
}
