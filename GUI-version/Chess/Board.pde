
import java.util.Arrays;

public class Board implements Cloneable {

    final static int totalPlaces = 64;
    final static int totalRows = 8;
    final static int totalColumns = 8;

    public final BoardPlace[] gameSpace1D;
    public final BoardPlace[][] gameSpace2D;

    public Board(Player player1, Player player2) {
        BoardPlace[][][] boardData = initializeBoard( player1, player2 );
        gameSpace1D = boardData[0][0];
        gameSpace2D = boardData[1];

    }
    
    public Board(BoardPlace[][] gameSpace2) { 
      gameSpace1D = new BoardPlace[totalPlaces];
      gameSpace2D = new BoardPlace[totalRows][totalColumns];
      this.clone(gameSpace2);
    }

    private BoardPlace[][][] initializeBoard (Player player1, Player player2) {
        BoardPlace[] startingBoard1D = new BoardPlace[totalPlaces];
        BoardPlace[][] startingBoard2D = new BoardPlace[totalRows][totalColumns];

        int count = 0; //count keeps track of the index of the single dimension array
        for (int i = 0; i < totalRows; i++) {
            for (int j = 0; j < totalColumns; j++) {
                //create a new space for pieces to reside
                BoardPlace newSpace = new BoardPlace( i+1, j+1 );
                //create a new pieces based on the location of the space
                Piece newPiece = getSpacesPiece(newSpace);
                //add the piece to the space
                newSpace.holding = newPiece;

                //add newly created Piece to players pieces array
                if (newPiece != null){
                    if (newPiece.isWhite)
                        player1.addPiece(newPiece);
                    else
                        player2.addPiece(newPiece);
                }
                //add space to board arrays
                startingBoard2D[i][j] = newSpace;
                startingBoard1D[count] = newSpace;
                count++;
            }
        }

        return new BoardPlace[][][] { {startingBoard1D}, startingBoard2D};
    }

    private Piece getSpacesPiece(BoardPlace startPos) {
        if (startPos.row > 2 && startPos.row < 7 ) return null;

        if (startPos.row == 2 || startPos.row == 7 ) return new Pawn(startPos);

        switch (startPos.columnInt) {
            case 1:
            case 8:
                return new Rook(startPos);
            case 2:
            case 7:
                return new Knight(startPos);
            case 3:
            case 6:
                return new Bishop(startPos);
            case 4:
                return new Queen(startPos);
            case 5:
                return new King(startPos);
            default:
                System.out.println("An Invalid Position Was Given to 'getSpacePieces' in Board");
                return null;
        }
    }


    public String displayBoard ( boolean isBlackMoving ) {

        StringBuilder currentGameBoard = new StringBuilder();
        int increaseBy = isBlackMoving ? -1 : 1;

        for (
              int i = isBlackMoving ? totalRows-1 : 0;
              !isBlackMoving && i < gameSpace2D.length || isBlackMoving && i > -1;
              i += increaseBy
        ) {
            currentGameBoard.append(i+1).append("| ").append(Arrays.toString(gameSpace2D[i])).append("|\n");
        }

        currentGameBoard.append("   | A | B | C | D | E | F | G | H |");

        return currentGameBoard.toString();
    }

    public void takeTurn(ChessTurn playersTurn, boolean testing) {
      
        Piece movingPiece = playersTurn.movingPiece;
        BoardPlace spaceMovingTo = playersTurn.moveTo;

        //update data in the piece that is moving
        BoardPlace oldSpace = movingPiece.position;
        oldSpace.holding = null;
        BoardPlace newSpace = movingPiece.position = spaceMovingTo;

        //update the space that the piece is moving to
        if (spaceMovingTo.holding != null) {
            spaceMovingTo.holding.isInGame = false;
            spaceMovingTo.holding.position = null;
        }
        spaceMovingTo.holding = movingPiece;
        
        if (!testing) {
          if ( (movingPiece.toString().equals("WP") && spaceMovingTo.row == 8) 
              || (movingPiece.toString().equals("BP") && spaceMovingTo.row == 1) )
          {   
            choices[0] = "Knight";
            choices[1] = "Queen";
            isChoosing = true;     
          } else 
              selectedPiece = null;
        
        }
        
        
        //update the board
        gameSpace2D[oldSpace.row-1][oldSpace.columnInt-1] = oldSpace;
        gameSpace2D[newSpace.row-1][newSpace.columnInt-1] = newSpace;

        gameSpace1D[(oldSpace.row-1)*8 + oldSpace.columnInt-1] = oldSpace;
        gameSpace1D[(newSpace.row-1)*8 + newSpace.columnInt-1] = newSpace;
    }
    
    public void transformPiece(Piece changingPiece, String pieceType) {
    
      boolean isWhite = changingPiece.getIsWhite();
      BoardPlace piecesSpace = changingPiece.position;
      BoardPlace startSpace = isWhite ? gameSpace1D[0] : gameSpace1D[gameSpace1D.length-1] ;
      Piece newPiece = pieceType == "Q" 
        ? new Queen(startSpace) 
        : new Knight(startSpace);
      newPiece.position = piecesSpace;
      piecesSpace.holding = newPiece;
      
      if (isWhite) gameLogic.player1.addPiece(newPiece);
      else gameLogic.player2.addPiece(newPiece);
      
      gameSpace2D[piecesSpace.row-1][piecesSpace.columnInt-1] = piecesSpace;
      gameSpace1D[(piecesSpace.row-1)*8 + piecesSpace.columnInt-1] = piecesSpace;
    }

    public BoardPlace getSpace (int rowInt, int colInt) {
        if ( rowInt < 1 || colInt < 1 || rowInt > 8 || colInt > 8 ) return null;
//        System.out.println("Row: " + rowInt + " Col: " + colInt);
        return gameSpace2D[rowInt-1][colInt-1];
    }

    public BoardPlace[][] getBoard2D () {
        return gameSpace2D;
    }
    
    public void clone(BoardPlace[][] gs2D) {
      
      int count = 0;
      
      for ( int i = 0; i < gs2D.length; i++ ) {
        BoardPlace[] row = gs2D[i];
      
        for ( int j = 0; j < gs2D.length; j++ ) {
           BoardPlace space = row[j];
           
           BoardPlace clonedSpace = new BoardPlace(space.row, space.columnInt);
           Piece clonedPiece = space.holding;
           clonedSpace.holding = clonedPiece != null ? clonedPiece.clone(clonedSpace, clonedPiece.getIsWhite()) : null;
      
           gameSpace2D[i][j] = clonedSpace;
           gameSpace1D[count++] = clonedSpace;        
        }
      
      }
      
      
    }
    

}
