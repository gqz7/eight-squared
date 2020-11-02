package com.company;

public abstract class Piece implements Movable {
    public boolean isInGame;
    public boolean isWhite;
    public BoardPlace position;

    public Piece( BoardPlace startPosition, boolean isWhite) {
        position = startPosition;
        isInGame = true;
        this.isWhite = isWhite;
    }
    @Override
    abstract public String toString();
}
