
import java.util.ArrayList;
import java.util.List;

public class Queen extends Piece {

    private String name;
    public Queen (BoardPlace startPos) {
        super(startPos);
        name = "Queen";
    }
    
    
    public Queen (BoardPlace startPos, boolean isWhite) {
        super(startPos, isWhite);
        name = "Queen";

    }
    
    @Override
    public Piece clone(BoardPlace pos, boolean isWhite) {
      return new Queen(pos, isWhite);
    }


    @Override
    public ChessTurn move(BoardPlace moving) {
        return new ChessTurn(this, moving);
    }

    @Override
    public String toString() {
        return (this.getIsWhite() ? "W" : "B") + "Q";
    }

    @Override
    public String getName() {
        return name;
    }
    @Override
    public BoardPlace[] getPossibleMoves( Board board) {
        Piece movingPiece = this;

        List<BoardPlace> movesList = new ArrayList<BoardPlace>();
        boolean isWhite = movingPiece.isWhite;
        BoardPlace piecePos = movingPiece.position;

        int tempRow = piecePos.row;
        int tempCol = piecePos.columnInt;

        for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
                boolean hitBlock = false;
                int blocksMoved = 1;
                while  (!hitBlock) {
                    BoardPlace possibleMove = board.getSpace(tempRow + blocksMoved * i, tempCol + blocksMoved * j );
                    if (possibleMove != null && possibleMove.isEmpty() ) {
                        movesList.add(possibleMove);
                        blocksMoved++;
                    } else if (possibleMove != null && possibleMove.hasEnemy(isWhite)) {
                        movesList.add(possibleMove);
                        hitBlock = true;
                    } else hitBlock = true;
                }
            }
        }

        return movesList.toArray( new BoardPlace[0] );
    }

}
