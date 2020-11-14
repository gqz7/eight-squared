
//GLOBAL VARS

  //tracker for how many frames have elapsed
  int frames = 0;
  
  Game gameLogic; //where all the game data is stored
  
  BoardPlace hoveredSpace;

  BoardPlace[] possibleMoves;
  
  Piece selectedPiece;

  int prevSecond = second();

  int boardSz = 800; //size of board width/height
  
  int spaceSz = boardSz / 8 ;
  
  int[][][] spacePos = new int[8][8][2];
  
  boolean playerChanged = true;
  
  boolean transitioning = false;
  int transitionClock = 0;
  
  color whiteColor = color(255, 247, 227);
  color blackColor = color(46, 39, 24);
void setup() {
  //set canvas size
  size(1280,1280); //w: 3840 - 1920 h: 2160 - 1080
  
  //create instance of the simplex noise class
  //background(255); // reset screen
  noStroke();
  //noLoop(); //uncomment to only render one frame

  //draw();
  gameLogic = new Game();
  gameLogic.gameStart();
}

//loop function that runs on a loop 
void draw() {
  
  manageTimer();
  
  frames++;
  
  clear(); // reset screen
  background(100); // reset screen

  renderGameInfo();

  translate(width/2, height/2);
  
  boolean isWhitesTurn = gameLogic.whitesTurn;

  drawBoard(!isWhitesTurn);
  
  if (transitioning) renderTransition();
  
}

public void drawBoard( boolean isBlack) {

    possibleMoves = 
      selectedPiece == null 
      ? new BoardPlace[0] 
      : selectedPiece.getPossibleMoves(gameLogic.gameBoard);

    //for ( BoardPlace p : possibleMoves ) print(p.notation + ", ");
    //println();
    
    boolean startsBlack = isBlack;

    fill(whiteColor);
    strokeWeight(1);
    noStroke();
    rect(-boardSz/2, -boardSz/2, boardSz, boardSz);
    textSize(boardSz/16);
    fill(blackColor);

    pushMatrix();
    
    translate(-boardSz/2 -spaceSz , -boardSz/2);
    
    int curX = width/2 - boardSz/2 - spaceSz;
    int curY = height/2 - boardSz/2;
    
    for (int i = 0; i < 9;++i) {
      pushMatrix();
      for (int j = 0; j < 9; ++j) {
        if(j == 0 && i != 8) {
          fill(0);
          String numStr = startsBlack ? i+1+"" : 8-i+"";
          text( numStr , boardSz/18, boardSz/12); 
          
        } else if ( i >= 0 && i < 8 ) {
          
          if (isBlack) { 
            fill(blackColor);
            rect(0,0, spaceSz, spaceSz);
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
              renderHighlight( 0, 0, (float) spaceSz,  (float) spaceSz);     
          
          if (Arrays.asList(possibleMoves).contains(renderingSpace))
              renderPossibleMove( spaceSz/10, spaceSz/10, (float) spaceSz-spaceSz/5,  (float) spaceSz-spaceSz/5); 
            
          isBlack = !isBlack;       
        } else if ( j != 0 ) {
          fill(0);
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
          playerChanged
          || transitioning
          || ( mouseX > width/2 + boardSz/2 && mouseX < width/2 - boardSz/2 )
          || ( mouseY > height/2 + boardSz/2 && mouseY < height/2 - boardSz/2 )
    ) return;

    if ( Arrays.asList(possibleMoves).contains(hoveredSpace) ) {
        println( selectedPiece.getName() + " to " + hoveredSpace.notation);

        ChessTurn playerMove = selectedPiece.move(hoveredSpace);
        gameLogic.gameAdvance(playerMove);
    } 
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
      selectedPiece = hoveredSpace.holding;
    } else {
      //println("That's not yours");
    }  
};

public void renderHighlight (float transX, float transY, float rectWidth, float rectHeight) {
    
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
  
  int tranistionPeriod = 50;

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
    
    if (renderingPiece.isWhite) 
      fill (200, 0, 200);
    else 
      fill (0, 200, 200);
    text(renderingPiece.toString(), boardSz/75, boardSz/12);
}

public void renderGameInfo () {
  
    int textSz = boardSz/30;
    
    color bgColor = color( 17, 22, 23 );
    color textColor = color(  255, 254, 248 );
    
    float infoBoardHeight = boardSz/4.7;
    
    int[] gameTimes = gameLogic.getPlayersTime();
    
    String turnStr = "Turn: " + gameLogic.getTurn();

    String playingStr = "Playing: " + (gameLogic.getWhitesTurn() ? "White" : "Black");

    String timeString = "Game: " + (gameTimes[0]+gameTimes[1]) + "\nWhite: " + gameTimes[0]  + "\n Black: " + gameTimes[1];
    
    textSize(textSz);
    noStroke();

    pushMatrix();
    
      
      fill(bgColor);
      translate(width/2 - boardSz/1.5, height/10 - boardSz/8);
      rect(0,0,boardSz*1.333, infoBoardHeight);
      
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
  
  if (transitioning) return;

  int curSecond = second();
  
  if (curSecond != prevSecond) {
  
    prevSecond = curSecond;
    
    boolean playingWhite = gameLogic.getWhitesTurn();
    
    gameLogic.advancePlayerTime(playingWhite);
      
  
  }
    

}
