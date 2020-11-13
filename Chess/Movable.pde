//package com.company.Chess.Logic.Pieces;

//import com.company.Chess.Logic.Enviorment.Board;
//import com.company.Chess.Logic.Enviorment.BoardPlace;
//import com.company.Chess.Logic.Control.Turn;

public interface Movable {

    public ChessTurn move(BoardPlace moving);

    public BoardPlace[] getPossibleMoves( Board board );

}
