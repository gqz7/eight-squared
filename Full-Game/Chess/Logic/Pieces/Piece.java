package com.company.Chess.Logic.Pieces;

import com.company.Chess.Logic.Enviorment.Board;
import com.company.Chess.Logic.Enviorment.BoardPlace;

public abstract class Piece implements Movable {
    public boolean isInGame;
    public boolean isWhite;
    public BoardPlace position;
    private String name;

    public Piece( BoardPlace startPosition) {
        position = startPosition;
        isInGame = true;

        if (startPosition.row < 3)
            isWhite = true;
        else isWhite = false;
    }
    @Override
    abstract public String toString();

    abstract public String getName();

    abstract public BoardPlace[] getPossibleMoves( Board board );

}
