import java.util.Arrays;

public class Game {

    private Player player1;
    private Player player2;

    private Board gameBoard;

    private int turn;
    private boolean whitesTurn;

    public Game () {
        initalizeGame();      
    }
    
    private void initalizeGame(){  
       turn = 1;
        whitesTurn = true;
        player1 = new Player(true);
        player2 = new Player(false);
        gameBoard = new Board(player1, player2);
    }

    private void gameAdvance( ChessTurn playersTurn ) {
        gameBoard.takeTurn(playersTurn, false);

        turn++;
        playerChanged = true;
        transitioning = true;
        transitionGraceSecond = true;
        transitionClock = 0;
        hoveredSpace = null;
        BoardPlace kingSpace = !whitesTurn ? player1.getKing().position : player2.getKing().position;
        playerInCheck = isChecked(gameBoard, kingSpace, !whitesTurn); 
        
        if (playerInCheck && isCheckMate()) endGame();
    }
    
    public void switchPlayers() {
      whitesTurn = !whitesTurn;
    }
    
    public void endGame() {
      playerLost = true;
      gamePaused = true;
    }

    public boolean getWhitesTurn () {
        return whitesTurn;
    }
    
    public void advancePlayerTime (boolean isWhite) {
      if (isWhite)
        player1.advanceTime();
      else
        player2.advanceTime();
    
    }

    public int[] getPlayersTime () {
        return new int[] {player1.getPlayTime(), player2.getPlayTime()};
    }

    public int getTurn() {
        return turn;
    }
    
    public boolean isCheckMate() {
      Player playerInCheck = !whitesTurn ? player1 : player2;
      List<Piece> pieces = playerInCheck.getAvailablePieces();
      
      for ( Piece p : pieces )
        if (filterMoves(p, !whitesTurn).length != 0) return false;
       
      return true;
      
    }
    
    public boolean isChecked ( Board b, BoardPlace kingsPosition, boolean testingWhite ) {
      
        List<Piece> opposingPieces = new ArrayList<Piece>();

        for ( BoardPlace s : b.gameSpace1D ) {
          if (s.holding != null && s.holding.getIsWhite() != testingWhite) opposingPieces.add(s.holding);
        }
        
        for ( Piece p : opposingPieces ) {
           if ( 
               Arrays.asList(p.getPossibleMoves(b)).contains(kingsPosition) ) {
               return true; 
           }
        }
        
        return false;
        
    }
    
    public BoardPlace[] filterMoves (Piece moving, boolean whitesPlaying) {
      BoardPlace[] possibleMovesUnfilltered = moving.getPossibleMoves(gameBoard);
      
      Player playingPlayer = whitesPlaying ? player1 : player2;
      List<BoardPlace> filtered = new ArrayList<BoardPlace>();
      Piece king = playingPlayer.getKing();
      int kingRow = king.position.row;
      int kingCol = king.position.columnInt;
      boolean movingKing = moving == king;
      for ( BoardPlace space : possibleMovesUnfilltered ) {
       
        if (movingKing) {
          kingRow = space.row;
          kingCol = space.columnInt;
        }
        
        Board testingBoard = new Board(gameBoard.gameSpace2D);
        BoardPlace kingPosition = testingBoard.getSpace(kingRow, kingCol);
        BoardPlace testSpace = testingBoard.getSpace( space.row, space.columnInt );
        Piece testMoving = testingBoard.getSpace( moving.position.row, moving.position.columnInt ).holding;
        
        testingBoard.takeTurn( new ChessTurn(testMoving, testSpace), true );
       
        if (!isChecked(testingBoard, kingPosition, king.getIsWhite())) {
           filtered.add(space);
        }
        
      }
      return filtered.toArray(new BoardPlace[0]);
    }
    
    
    public List<Piece> getLostPieces(boolean isWhite) {
    
      if (isWhite)
        return player1.getLostPieces();
      else 
        return player2.getLostPieces();
    }

    public void printCurrentGame () {
        System.out.println("\n________________________________________________\n");
        System.out.println("TURN: " + turn + "\t\tMOVING: " + (whitesTurn ? "WHITE" : "BLACK") +"\n");
        System.out.println(gameBoard.displayBoard(whitesTurn));
        System.out.println("________________________________________________\n");
    }

    public void printPlayerPieces () {
        System.out.println("\nPLAYERS PIECES\n");
        System.out.println("\n________________________________________________\n");
        System.out.println("PLAYER ONE:\n");
        System.out.println(player1);
        System.out.println("\n________________________________________________\n");
        System.out.println("PLAYER TWO:\n");
        System.out.println(player2);

    }
}
