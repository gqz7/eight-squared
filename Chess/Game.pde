
public class Game {

    private Player player1;
    private Player player2;

    private Board gameBoard;

    private int turn;
    public boolean whitesTurn;

    public Game () {

        turn = 1;
        whitesTurn = true;
        player1 = new Player(true);
        player2 = new Player(false);

        gameBoard = new Board(player1, player2);
    }

    private void gameStart() {
        
        //boolean gameEnded = false;
        turn = 1;
        whitesTurn = true;
        printCurrentGame();
        
    }

    private void gameAdvance( ChessTurn playersTurn ) {
        gameBoard.takeTurn(playersTurn);

        turn++;
        playerChanged = true;
        transitioning = true;
        transitionClock = 0;
        selectedPiece = null;
        hoveredSpace = null;
        
        printCurrentGame();
        //if (gameEnded = true) 
        //  gameStart()
    }
    
    public void switchPlayers() {
      whitesTurn = !whitesTurn;
    }

    public boolean getWhitesTurn () {
        return whitesTurn;
    }

    public int getTurn() {
        return turn;
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
