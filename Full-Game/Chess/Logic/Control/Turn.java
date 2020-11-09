package com.company.Chess.Logic.Control;

import com.company.Chess.Logic.Enviorment.BoardPlace;
import com.company.Chess.Logic.Pieces.Piece;

public class Turn {

    public Piece movingPiece;
    public BoardPlace moveTo;

    public Turn(Piece movingPiece, BoardPlace moveTo) {
        this.movingPiece = movingPiece;
        this.moveTo = moveTo;
    }
}
