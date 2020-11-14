
import java.util.Arrays;

public class Player {
    private boolean isWhite;
    private Piece[] pieces;
    private int totalPieces;
    private int playTime;

    public Player (boolean isWhite) {
        this.isWhite = isWhite;

        totalPieces = 0;
        playTime = 0;
        pieces = new Piece[16];

    }

    public int getPlayTime () {
      return playTime;
    };
    
    public void advanceTime() { 
      playTime++;
    };

    public void addPiece (Piece newPiece ) {
        pieces[totalPieces] = newPiece;
        totalPieces++;
    }

    @Override
    public String toString() {
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
}
