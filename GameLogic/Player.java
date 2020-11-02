package com.company;

public class Player {
    private boolean isWhite;
    private Piece[] pieces;

    public Player (boolean isWhite) {
        this.isWhite = isWhite;
        this.pieces = new Piece[16];
    }

}
