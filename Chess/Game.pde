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
        gameBoard.takeTurn(playersTurn);

        turn++;
        playerChanged = true;
        transitioning = true;
        transitionGraceSecond = true;
        transitionClock = 0;
        hoveredSpace = null;
        
        println(isChecked(gameBoard));
        
    }
    
    public void switchPlayers() {
      whitesTurn = !whitesTurn;
    }
    
    public void endGame() {
      initalizeGame();
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
    
    public boolean isChecked ( Board b) {
      
        Player playingPlayer  = whitesTurn ? player1 : player2;
        Player opposingPlayer = !whitesTurn ? player1 : player2;  
        BoardPlace kingsPlace = playingPlayer.getKing().getPosition();
        List<Piece> opposingPieces = opposingPlayer.getAvailablePieces();
        
           //List<BoardPlace> possibleMoves = Arrays.asList(p.getPossibleMoves(gameBoard));
           //if (possibleMoves.contains(kingsPlace)) return true;
        for ( Piece p : opposingPieces )
           if ( Arrays.asList(p.getPossibleMoves(b)).contains(kingsPlace) ) return true; 

        return false;
        
    }
    
    public BoardPlace[] filterMoves (Piece moving) {
      
      BoardPlace[] possibleMovesUnfilltered = moving.getPossibleMoves(gameBoard);
      
      List<BoardPlace> filtered = new ArrayList<BoardPlace>();
      
      for ( BoardPlace space : possibleMovesUnfilltered ) {
        
        Board testingBoard = new Board(gameBoard.gameSpace2D, gameBoard.gameSpace1D);
        
        testingBoard.takeTurn( new ChessTurn(moving, space));
        
        if (!isChecked(testingBoard)) filtered.add(space);
      
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
