import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//GLOBAL VARS

//tracker for how many frames have elapsed
int frames = 0;

Game gameLogic; //where all the game data is stored

BoardPlace hoveredSpace;

BoardPlace[] possibleMoves;
BoardPlace[] noMoves = new BoardPlace[0];

Piece selectedPiece;

Map<String, PImage> pieceImagesMap = new HashMap<String, PImage>();
String imageDirectoryPath = "./images/";

int prevSecond = second();

int boardSz = 600; //set to 1000 for 4K resolution //size of board width/height

int tranistionPeriod = 50;
int endGamePeriod = 300;
  
int spaceSz = boardSz / 8 ;

int[][][] spacePos = new int[8][8][2];

String[] choices = new String[] {"Knight", "Queen"};

boolean playerChanged = true;
boolean playerInCheck = false;
boolean playerLost = false;
boolean transitioning = false;
boolean transitionGraceSecond = false;
boolean gamePaused = false;

int endGameClock = 0;
int transitionClock = 0;

boolean switchedPieces = false;
boolean isChoosing = false;

color whiteColor = color(255, 247, 227);
color blackColor = color(46, 39, 24);

int resignBtnX, resignBtnY, resignBtnWidth, resignBtnHeight;
int pauseBtnX, pauseBtnY, pauseBtnWidth, pauseBtnHeight;
int leftBtnX, leftBtnY, leftBtnWidth, leftBtnHeight;
int rightBtnX, rightBtnY, rightBtnWidth, rightBtnHeight;

void setup() {
  //set canvas size
  size(1920, 1080); //w: 3840 - 1920 h: 2160 - 1080

  noStroke();
  loadImages();
  setBtnPositions();

  gameLogic = new Game();
  gameLogic.initalizeGame();
}

//loop function that runs on a loop 
void draw() {

  manageTimer();

  frames++;

  clear(); // reset screen
  background(30); // reset screen

  renderGameInfo();

  translate(width/2, height/2);

  boolean isWhitesTurn = gameLogic.whitesTurn;

  drawBoard(!isWhitesTurn);
  
  if ( isChoosing ) renderChoices();
  else if (transitioning) renderTransition();
  else if (playerLost) renderLostScreen();
  else renderExtras();

}
  
public void drawBoard( boolean isBlack) {
  
  possibleMoves = 
    selectedPiece == null 
      ? noMoves 
      : switchedPieces 
        ? gameLogic.filterMoves(selectedPiece, gameLogic.getWhitesTurn())
        : possibleMoves;
            

  if (switchedPieces) switchedPieces = false;

  boolean startsBlack = isBlack;

  fill(whiteColor);
  strokeWeight(1);
  noStroke();
  rect(-boardSz/2, -boardSz/2, boardSz, boardSz);
  textSize(boardSz/16);
  fill(blackColor);

  pushMatrix();

  translate(-boardSz/2 -spaceSz, -boardSz/2);

  renderLostPieces();

  int curX = width/2 - boardSz/2 - spaceSz;
  int curY = height/2 - boardSz/2;

  for (int i = 0; i < 9; ++i) {
    pushMatrix();
    for (int j = 0; j < 9; ++j) {
      if (j == 0 && i != 8) {
        fill(255);
        String numStr = startsBlack ? i+1+"" : 8-i+"";
        text( numStr, boardSz/18, boardSz/12);
      } else if ( i >= 0 && i < 8 ) {

        if (isBlack) { 
          fill(blackColor);
          rect(0, 0, spaceSz, spaceSz);
        }

        BoardPlace renderingSpace;

        if (startsBlack) 
          renderingSpace = gameLogic.gameBoard.gameSpace2D[i][j-1];
        else
          renderingSpace = gameLogic.gameBoard.gameSpace2D[7-i][j-1];


        if (!renderingSpace.isEmpty()) {
          renderPiece(renderingSpace.holding);
          fill(blackColor);
        } 

        if ( selectedPiece != null && renderingSpace.holding == selectedPiece ) 
          renderHighlight( 0, 0, (float) spaceSz, (float) spaceSz);     

        if (Arrays.asList(possibleMoves).contains(renderingSpace))
          renderPossibleMove( spaceSz/10, spaceSz/10, (float) spaceSz-spaceSz/5, (float) spaceSz-spaceSz/5); 

        isBlack = !isBlack;
      } else if ( j != 0 ) {
        fill(200);
        String letterStr = mapNumToChessLetter(j);
        text( letterStr, boardSz/20, boardSz/12 );
      }

      if ( playerChanged && i >= 0 && i < 8 && j >= 1 && j < 9 ) {
        //println(curX + ", " + curY);
        spacePos[i][j-1][0] = curX;
        spacePos[i][j-1][1] = curY;
      }

      translate(spaceSz, 0);
      curX += spaceSz;
    }
    popMatrix();
    curX -= spaceSz * 9;
    translate(0, spaceSz);
    curY += spaceSz;
    isBlack = !isBlack;
  }
  popMatrix();

  if (!playerChanged) {
    highlightSpace();
  }

  playerChanged = false;
}

public void mousePressed() { 

  if ( //check if the mouse is in the play area
    (playerChanged && !isChoosing)
    || (transitioning && !isChoosing)
    ) return;

  if (
      !isChoosing && !gamePaused && (
      ( mouseX > width/2 - boardSz/2 && mouseX < width/2 + boardSz/2 )
      && ( mouseY <= height/2 + boardSz/2 && mouseY >= height/2 - boardSz/2 )) )
     {
        if ( Arrays.asList(possibleMoves).contains(hoveredSpace) ) {
          ChessTurn playerMove = selectedPiece.move(hoveredSpace);
          gameLogic.gameAdvance(playerMove);
        } else {
        
          //check to make sure the space the player is selection is not empty, 
          //hoveredSpace will be null when the game starts and right after a move before the board has been hovered
          if (
            hoveredSpace == null 
            || hoveredSpace.holding == null 
            ) return;

          Piece hoverP = hoveredSpace.holding;

          boolean isPlayersPiece = ( hoverP.isWhite && gameLogic.whitesTurn ) || ( !hoverP.isWhite && !gameLogic.whitesTurn );

          if (isPlayersPiece) {
            //println(hoveredSpace.holding.toString() + ": " + hoveredSpace.holding.position.notation);
            if (selectedPiece == hoveredSpace.holding) selectedPiece = null;
            else {
              switchedPieces = true;
              selectedPiece = hoveredSpace.holding;
            } 
          }
    
        }
        
    } else handleButtonClick();
};

public void handleButtonClick( ) {
    String choice = getClickedButton();

   if (choice == "pause") gamePaused = !gamePaused;
    
   if (gamePaused) return;
    
   if (choice == "leftChoice")
      choice = choices[0];
   else if (choice =="rightChoice")
      choice = choices[1];
       
  switch (choice) {
    case "Queen":                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
      gameLogic.gameBoard.transformPiece(selectedPiece, "Q");
      isChoosing = false;
      selectedPiece = null;
    break;
    case "Knight":
      //println("Knight Selected");
      gameLogic.gameBoard.transformPiece(selectedPiece, "K");
      isChoosing = false;
      selectedPiece = null;
    break;
    case "Resign":
      //Game Over
      gameLogic.endGame();
      isChoosing = false;
    break;
    case "Continue":
      isChoosing = false;
    break;
    case "resign":
      choices[0] = "Resign";
      choices[1] = "Continue";
      isChoosing = true;
    break;
    default:
      //println("An Unaccounted For Choice Was Made");
    break;  
  }
}



public void renderHighlight (float transX, float transY, float rectWidth, float rectHeight) {

  if (isChoosing) return;

  color highlightColor = gameLogic.whitesTurn ? color(186, 125, 180) : color(125, 182, 186); //light-tan: 255, 237, 194

  noFill();
  stroke(highlightColor); 
  strokeWeight(10);

  rect(
    transX, 
    transY, 
    rectWidth, 
    rectHeight
    );
  noStroke();
}

public void renderPossibleMove (float transX, float transY, float rectWidth, float rectHeight) {

  color spaceColor = color(0, 200, 100);//gameLogic.whitesTurn ? color(186, 125, 180) : color(125, 182, 186); //light-tan: 255, 237, 194

  fill(spaceColor); 

  rect(
    transX, 
    transY, 
    rectWidth, 
    rectHeight
    );
  noStroke();
}

public void renderTransition() {

  fill(17, 22, 23);
  stroke(17, 22, 23);
  float rectX = -boardSz/2 - spaceSz;
  float rectWidth = boardSz + spaceSz*2;
  transitionClock++;

  if (transitionClock == tranistionPeriod)
    gameLogic.switchPlayers();

  if (transitionClock <= tranistionPeriod) {

    float rectY = -boardSz/2;
    float rectHeight = boardSz * transitionClock/tranistionPeriod;
    rect( rectX, rectY, rectWidth, rectHeight);
  } else if (transitionClock < tranistionPeriod*2) {

    float rectY = boardSz/2;
    float rectHeight = -boardSz * (2 - (float) transitionClock/tranistionPeriod);
    rect( rectX, rectY, rectWidth, rectHeight);
  } else {
    transitioning = false;
    transitionClock = 0;
  }
}

public void renderPiece (Piece renderingPiece) {
  
  String imgName = (renderingPiece.isWhite ? "w" : "b" ) + renderingPiece.getName();

  image( pieceImagesMap.get(imgName), 0, 0, spaceSz, spaceSz);
}

public void renderLostPieces() {
  pushMatrix();

  List<Piece> lostWhitePieces = gameLogic.getLostPieces(true); //boolean passed indicates if it will recieve White, or Black player's pieces

  List<Piece> lostBlackPieces = gameLogic.getLostPieces(false);

  translate( -spaceSz*3, 0);
  int wCount = 0;
  for ( Piece p : lostWhitePieces ) {
    pushMatrix();
    translate( wCount % 2 == 0 ? 0 : spaceSz, spaceSz * (int)(wCount/2) );
    renderPiece(p);
    wCount++;
    popMatrix();
  }

  int bCount = 0;
  translate( spaceSz*6 + boardSz, 0);
  for ( Piece p : lostBlackPieces ) {
    pushMatrix();
    translate( bCount % 2 == 0 ? 0 : spaceSz, spaceSz * (int)(bCount/2) );
    renderPiece(p);
    bCount++;
    popMatrix();
  }

  popMatrix();
}

public void renderGameInfo () {

  int textSz = boardSz/30;

  color bgColor = color( 17, 22, 23 );
  color textColor = color(  255, 254, 248 );

  float infoBoardHeight = boardSz/4.7;

  int[] gameTimes = gameLogic.getPlayersTime();

  String turnStr = "Turn: " + gameLogic.getTurn();

  String playingStr = "Playing: " + (gameLogic.getWhitesTurn() ? "White" : "Black");

  String totalGameTime = formatTime(gameTimes[0]+gameTimes[1]);
  String whitesTime = formatTime(gameTimes[0]);
  String blacksTime = formatTime(gameTimes[1]);

  String timeString = "Game: " + totalGameTime + "\nWhite: " + whitesTime + "\n Black: " + blacksTime;

  textSize(textSz);
  noStroke();

  pushMatrix();


  fill(bgColor);
  translate(width/2 - boardSz/1.5, height/10 - boardSz/8);
  rect(0, 0, boardSz*1.333, infoBoardHeight);

  fill(textColor);
  text(turnStr, boardSz/5, infoBoardHeight/2 + textSz/2);
  text(playingStr, boardSz/1.8, infoBoardHeight/2 + textSz/2);
  text(timeString, boardSz, infoBoardHeight/2 - textSz);

  popMatrix();
}

public void highlightSpace() {

  for ( int i = 0; i < 8; ++i ) {

    for ( int j = 0; j < 8; ++j ) {

      int x = spacePos[i][j][0];
      int y = spacePos[i][j][1];
      BoardPlace space;

      if (!gameLogic.whitesTurn) 
        space = gameLogic.gameBoard.gameSpace2D[i][j];
      else
        space = gameLogic.gameBoard.gameSpace2D[7-i][j];

      if (mouseX > x && mouseX < x+spaceSz && mouseY > y && mouseY < y+spaceSz) {

        hoveredSpace = space;

        renderHighlight(
          x-width/2, 
          y-height/2, 
          (float) spaceSz, (float) spaceSz
          );

        return;
      }
    }
  }
}

public void loadImages() {


  String[] chessPieceNames = new String[] {"Pawn", "Bishop", "Rook", "Knight", "King", "Queen"};

  for ( String name : chessPieceNames ) {

    int count = 0;
    while ( count < 2 ) {
      String pieceFileName = ( count == 0 ? "w" : "b" ) + name;
      PImage image = loadImage( imageDirectoryPath + pieceFileName + ".png");
      pieceImagesMap.put(pieceFileName, image);
      count++;
    }
  }
}

public String mapNumToChessLetter ( int number ) {
  //number;
  switch (number) {
  case 1: 
    return "A";
  case 2: 
    return "B";
  case 3: 
    return "C";
  case 4: 
    return "D";
  case 5: 
    return "E";
  case 6: 
    return "F";
  case 7: 
    return "G";
  case 8: 
    return "H";
  default:
    return "Z";
  }
} 

public void manageTimer() {

  if (transitioning || gamePaused) return;

  int curSecond = second();

  if (curSecond != prevSecond) {

    prevSecond = curSecond;

    if (transitionGraceSecond) {
      transitionGraceSecond = false;
      return;
    }

    boolean playingWhite = gameLogic.getWhitesTurn();

    gameLogic.advancePlayerTime(playingWhite);
  }
}

public String formatTime( int secs ) {

  int hours = secs / 3600;
  secs -= hours*3600;

  int mins = secs / 60;
  secs -= mins * 60;

  return hours + ":" + (mins > 9 ? mins : "0" + mins ) + ":" + (secs > 9 ? secs : "0" + secs );
} 

public void renderChoices() {


  color bgColor = color( 17, 22, 23 );
  color textColor = color(  255, 254, 248 );

  pushMatrix();
  fill(bgColor);
  strokeWeight(1);
  noStroke();
  rect(leftBtnX-width/2, leftBtnY-height/2, leftBtnWidth, leftBtnHeight);
  rect(rightBtnX-width/2, rightBtnY-height/2, rightBtnWidth, rightBtnHeight);
  textSize(boardSz/20);
  fill(textColor);
  text(choices[0], leftBtnX-width/2+rightBtnWidth*.25, boardSz/64);
  text(choices[1], rightBtnX-width/2+rightBtnWidth*.25, boardSz/64);

  popMatrix();
}


public void renderExtras() {
    renderPauseBtn();
    renderResignBtn();
  
}

public void renderLostScreen() {
  
  fill(17, 22, 23);
  stroke(17, 22, 23);
  float rectX = -boardSz/2 - spaceSz;
  float rectWidth = boardSz + spaceSz*2;

  endGameClock++;

  if (endGameClock < endGamePeriod/3) {

    float rectY = -boardSz/2;
    float rectHeight = boardSz/2*3 * endGameClock/endGamePeriod;
    rect( rectX, rectY, rectWidth, rectHeight);
    rect( rectX, boardSz/2, rectWidth, -rectHeight);
    
    
  } else if (endGameClock < endGamePeriod*2/3) {
      String endText = gameLogic.getWhitesTurn() ? "Black Wins" : "White Wins";
    
        rect(rectX, -boardSz/2, rectWidth, boardSz);
        fill(255);
        text(endText, -boardSz/6, 0);
        
  } else if (endGameClock == endGamePeriod*2/3) {
    rect(rectX, -boardSz/2, rectWidth, boardSz);
    gameLogic.initalizeGame();
    
  } else if (endGameClock < endGamePeriod) {
    
    float rectHeight = -boardSz * (2 - (float) endGameClock/(endGamePeriod/2));
    rect( rectX, -boardSz/2, rectWidth, -rectHeight);
    rect( rectX, boardSz/2, rectWidth, rectHeight);

  } else {
    playerLost = false;
    endGameClock = 0;
    gamePaused = false;
  }
  
}

public void setBtnPositions () {
  resignBtnX = boardSz/2 + boardSz/16 + width/2;
  resignBtnY = boardSz/2 + boardSz/10 + height/2;
  resignBtnWidth = boardSz/4;
  resignBtnHeight = boardSz/8;
  
  leftBtnX = -boardSz/2 + boardSz/16  + width/2;
  leftBtnY =  - boardSz/8 + height/2; 
  leftBtnWidth = boardSz/4 + boardSz/8;
  leftBtnHeight = boardSz/4;
  
  rightBtnX = width/2 + boardSz/8 - boardSz/16 ;
  rightBtnY = height/2 - boardSz/8;
  rightBtnWidth = boardSz/4 + boardSz/8; 
  rightBtnHeight = boardSz/4;
  
  pauseBtnX = -boardSz/2 - boardSz/4 + width/2;;
  pauseBtnY = boardSz/2 + boardSz/10 + height/2;
  pauseBtnWidth = boardSz/8; 
  pauseBtnHeight = boardSz/8;

}

public void renderResignBtn () {
  fill(0);
  noStroke();
  rect(resignBtnX - width/2, resignBtnY - height/2, resignBtnWidth, resignBtnHeight);

  textSize(boardSz/16);
  fill(255);
  text("Resign", resignBtnX - width/2 + spaceSz/6, resignBtnY - height/2 + spaceSz/1.5);
 
}

public void renderPauseBtn () {
  fill(0);
  noStroke();
  rect(pauseBtnX - width/2, pauseBtnY - height/2, pauseBtnWidth, pauseBtnHeight);
  fill(255);
  if (gamePaused) {
    triangle( 
      pauseBtnX - width/2 + pauseBtnWidth/5 , 
      pauseBtnY - height/2 + pauseBtnHeight/6, 
      pauseBtnX - width/2 + pauseBtnWidth/5 , 
      pauseBtnY - height/2 + pauseBtnHeight/6 + pauseBtnHeight*2/3, 
      pauseBtnX - width/2 + pauseBtnWidth/1.2, 
      pauseBtnY - height/2 + pauseBtnHeight/2
    );
  } else {
    rect(pauseBtnX - width/2 + pauseBtnWidth/5 , pauseBtnY - height/2 + pauseBtnHeight/6, pauseBtnWidth/6, pauseBtnHeight*2/3);
    rect(pauseBtnX - width/2 + pauseBtnWidth/1.6 , pauseBtnY - height/2 + pauseBtnHeight/6, pauseBtnWidth/6, pauseBtnHeight*2/3);
  }
}

public String getClickedButton () {

  if (mouseX < leftBtnX + leftBtnWidth && mouseX > leftBtnX  && mouseY > leftBtnY && mouseY < leftBtnY+leftBtnHeight )
    return "leftChoice";
  else if (mouseX < rightBtnX + rightBtnWidth && mouseX > rightBtnX  && mouseY > rightBtnY && mouseY < rightBtnY+rightBtnHeight)
    return "rightChoice";
  else if (!isChoosing && mouseX < resignBtnX + resignBtnWidth && mouseX > resignBtnX  && mouseY > resignBtnY && mouseY < resignBtnY+resignBtnHeight )
    return "resign";
  else if (!isChoosing && mouseX < pauseBtnX + pauseBtnWidth && mouseX > pauseBtnX  && mouseY > pauseBtnY && mouseY < pauseBtnY+pauseBtnHeight )
    return "pause";

  return "none";

}
