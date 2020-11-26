
public interface Movable {

    public ChessTurn move(BoardPlace moving);

    public BoardPlace[] getPossibleMoves( Board board );

}
