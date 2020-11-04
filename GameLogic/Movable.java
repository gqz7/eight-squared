package com.company;

public interface Movable {

    public Turn move(BoardPlace moving);

    public BoardPlace[] getPossibleMoves( Board board );

}
