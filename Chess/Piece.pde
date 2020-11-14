
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
    
    public boolean getIsInGame() { return isInGame; };
    
    @Override
    abstract public String toString();

    abstract public String getName();

    abstract public BoardPlace[] getPossibleMoves( Board board );

}
