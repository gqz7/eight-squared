
import java.util.ArrayList;
import java.util.List;

public class King extends Piece {

    private String name;
    public King (BoardPlace startPos) {
        super(startPos);
        name = "King";

    }
    
    public King (BoardPlace startPos, boolean isWhite) {
        super(startPos, isWhite);
        name = "King";

    }
    
    @Override
    public Piece clone(BoardPlace pos, boolean isWhite) {
      return new King(pos, isWhite);
    }
    @Override
    public ChessTurn move(BoardPlace moving) {
        return new ChessTurn(this, moving);
    }

    @Override
    public String toString() {
        return (this.getIsWhite() ? "W" : "B") + "K";
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public BoardPlace[] getPossibleMoves( Board board ) {

        Piece movingPiece = this;

        List<BoardPlace> movesList = new ArrayList<BoardPlace>();
        boolean isWhite = movingPiece.isWhite;
        BoardPlace piecePos = movingPiece.position;

        int tempRow = piecePos.row;
        int tempCol = piecePos.columnInt;

        for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
                if ( !(i == 0 && j == 0) ){
                    BoardPlace possibleMove = board.getSpace(tempRow + i, tempCol + j );
                    if (possibleMove != null && (possibleMove.isEmpty() || possibleMove.hasEnemy(isWhite)))
                        movesList.add(possibleMove);

                }
            }
        }

        return movesList.toArray( new BoardPlace[0] );
    }
}
