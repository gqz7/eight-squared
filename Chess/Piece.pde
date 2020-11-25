
public abstract class Piece implements Movable {
    private boolean isInGame;
    private boolean isWhite;
    public BoardPlace position;

    public Piece( BoardPlace startPosition) {
        position = startPosition;
        isInGame = true;

        if (startPosition.row < 5 )
            isWhite = true;
        else isWhite = false;
    }
    
    public boolean getIsInGame() { return isInGame; };
    
    public boolean getIsWhite() { return isWhite; };
    
    public BoardPlace getPosition() { return position; };
    
    @Override
    abstract public String toString();

    abstract public String getName();

    abstract public BoardPlace[] getPossibleMoves( Board board );

}
