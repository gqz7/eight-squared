public class ChessTurn {
  
    public Piece movingPiece;
    public BoardPlace moveTo;

    public ChessTurn(Piece movingPiece, BoardPlace moveTo) {
        this.movingPiece = movingPiece;
        this.moveTo = moveTo;
    }
  
}
