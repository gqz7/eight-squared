package com.company;

public class Turn {

    public Piece movingPiece;
    public Piece taken;
    public BoardPlace moveTo;


    public Turn(Piece movingPiece, BoardPlace moveTo) {
        this.movingPiece = movingPiece;
        this.moveTo = moveTo;
    }
}
