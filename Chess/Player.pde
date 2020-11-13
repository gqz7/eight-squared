
import java.util.Arrays;

public class Player {
    private boolean isWhite;
    private Piece[] pieces;
    private int totalPieces;

    public Player (boolean isWhite) {
        this.isWhite = isWhite;

        totalPieces = 0;
        pieces = new Piece[16];

    }

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

    public ChessTurn makeTurn( Board board) {

        //Object[] filtered = Arrays.stream(pieces).filter( piece -> {
        //    if ( piece == null) return false;
        //    return piece.isInGame;
        //}).toArray();

        //Piece[] playablePieces = new Piece[filtered.length];

        //for (int i = 0; i < filtered.length; i++) {
        //    if (filtered[i] instanceof Piece) {
        //        playablePieces[i] = (Piece) filtered[i];
        //    }
        //}
        Piece[] playablePieces = pieces;
        System.out.println("Select A Piece To Move...");
        for (int i = 0; i < playablePieces.length; i++) {
            Piece p = playablePieces[i];
            System.out.println(i+1 + ") " + p.getName() + ", " + p.position.notation);
        }
        while (true) {
            int pieceInt = selectPiece(playablePieces.length);
            BoardPlace[] possibleMoves = playablePieces[pieceInt-1].getPossibleMoves( board );
            if (possibleMoves.length > 0) {
                int moveInt = selectMove(possibleMoves);
                if (moveInt != possibleMoves.length+1)
                    return new ChessTurn(playablePieces[pieceInt-1], possibleMoves[moveInt-1]);
            }
            System.out.println("\nThat piece does not have any possible moves, please select another piece.");
        }
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
