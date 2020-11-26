
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Player {
    private boolean isWhite;
    private boolean isInCheck;
    private List<Piece> pieces;
    private int totalPieces;
    private int playTime;

    public Player (boolean isWhite) {
        this.isWhite = isWhite;
        isInCheck = false;
        totalPieces = 0;
        playTime = 0;
        pieces = new ArrayList<Piece>();

    }

    public void checkPlayer() {
        isInCheck = true;
    }

    public void uncheckPlayer(){
        isInCheck = false;
    }
    
    private boolean isKing (Piece p) {
       return  p.getName().equals("King") ;
    }

    public void advanceTime() { 
      playTime++;
    };

    public void addPiece ( Piece newPiece ) {
        pieces.add(newPiece);
    }
    
    
    @Override 
    public String toString() {
      return isWhite ? "White Player" : "Black Player";
    }


    public String getPlayerPiecesString() {
        String playersPieces = "";
        for ( Piece gamePiece : pieces ) {
            playersPieces += (gamePiece + ": " + gamePiece.position.notation + ": isInGame; " + gamePiece.isInGame + "\n");
        }
        return playersPieces;
    }

    public int selectPiece( int playable) {
        return CLI.numberIntQuestion("\nSelect A Piece\nEnter a piece's corresponding number", 1, playable );
    }

    public int selectMove( BoardPlace[] possibleMoves) {
        System.out.println("Select A Move...");
        for (int i = 0; i < possibleMoves.length; i++) {
            BoardPlace move = possibleMoves[i];
            System.out.println(i+1 + ") " + move.notation);
        }
        System.out.println(possibleMoves.length+1 + ") Select Another Piece To Move");

        return CLI.numberIntQuestion("\nSelect A Move\nEnter a move's corresponding number", 1, possibleMoves.length+1 );
    }
    
    public List<Piece> getLostPieces() {
       List<Piece> lostPieces = new ArrayList();
       for (Piece p : pieces) {
         if (!p.getIsInGame())
           lostPieces.add(p);
       }
       return lostPieces;
    }

    public List<Piece> getAvailablePieces() {
       List<Piece> availablePieces = new ArrayList();
       for (Piece p : pieces) {
         if (p.getIsInGame())
           availablePieces.add(p);
       }
       return availablePieces;
    }
    
    public int getPlayTime () {
      return playTime;
    };
    
    public boolean getCheckStatus () {return isInCheck;} 
     
    public boolean getIsWhite() {return isWhite;}
  
    public Piece getKing() {
      
        for (Piece p : pieces) {
          if ( isKing(p) ) return p;
        }
        return null;
    }
    
}
