package com.company.ChessLogic.Pieces;

import com.company.ChessLogic.Enviorment.Board;
import com.company.ChessLogic.Enviorment.BoardPlace;
import com.company.ChessLogic.Control.Turn;

public interface Movable {

    public Turn move(BoardPlace moving);

    public BoardPlace[] getPossibleMoves( Board board );

}
