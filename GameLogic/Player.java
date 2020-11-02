package com.company;

public class Player {
    private boolean isWhite;
    private Piece[] pieces;
    private int totalPieces;

    public Player (boolean isWhite) {
        this.isWhite = isWhite;

        totalPieces = 0;
        pieces = new Piece[16];

    }

    public void addPiece (Piece newPiece ) {
        pieces[totalPieces] = newPiece;
        totalPieces++;
    }

    @Override
    public String toString() {
        String playersPieces = "";
        for ( Piece gamePiece : pieces ) {
            playersPieces += (gamePiece + ": " + gamePiece.position.notation + ": isInGame; " + gamePiece.isInGame + "\n");
        }
        return playersPieces;
    }

}
