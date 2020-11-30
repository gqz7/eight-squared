
import java.util.ArrayList;
import java.util.List;

public class King extends Piece {

    private String name;
    private boolean hasMoved; //only needed for rook and king for castling 
    
    public King (BoardPlace startPos) {
        super(startPos);
        name = "King";
        hasMoved = false;

    }
    
    public King (BoardPlace startPos, boolean isWhite) {
        super(startPos, isWhite);
        name = "King";
        hasMoved = false;
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
    //if king hasnt moved, check for castle posibility
        //check for CASTLE left
          //if three spaces to left are empty (bcd)
          //if rook hasnt moved also (a) 
         //move king two to left (c), move rook one to left of king (d)
        
        //check for CASTLE right
          //if two spaces to left are empty (fg)
          //if rook hasnt moved also (h)
         //move king two to right (g), move rook one to right of king (f)
        
        
        return movesList.toArray( new BoardPlace[0] );
    }
}
