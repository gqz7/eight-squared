package com.company;

import java.util.Arrays;

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

    public Turn makeTurn() {

        Object[] filtered = Arrays.stream(pieces).filter( piece -> piece.isInGame).toArray();
        Piece[] playablePieces = new Piece[filtered.length];

        for (int i = 0; i < filtered.length; i++) {
            if (filtered[i] instanceof Piece) {
                playablePieces[i] = (Piece) filtered[i];
            }
        }

        System.out.println("Select A Piece To Move...");
        for (int i = 0; i < playablePieces.length; i++) {
            Piece p = playablePieces[i];
            System.out.println(i+1 + ") " + p.getName() + ", " + p.position.notation);
        }

        int selectedPiece = CLI.numberIntQuestion("Enter a number", 1, playablePieces.length);

        return new Turn( playablePieces[0], playablePieces[0].position);
    }
}
