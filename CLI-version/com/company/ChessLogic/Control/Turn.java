package com.company.ChessLogic.Control;

import com.company.ChessLogic.Enviorment.BoardPlace;
import com.company.ChessLogic.Pieces.Piece;

public class Turn {

    public Piece movingPiece;
    public BoardPlace moveTo;

    public Turn(Piece movingPiece, BoardPlace moveTo) {
        this.movingPiece = movingPiece;
        this.moveTo = moveTo;
    }
}
