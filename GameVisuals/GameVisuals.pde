
//GLOBAL VARS
  //Noise algorithm that produces values used in this animation, not made by me

  //width and height of canvas
  int WIDTH = 1920;//3840; //1920
  int HEIGHT = 1080;//2160; //1080
  //tracker for how many frames have elapsed
  int frames = 0;

  int boardSz = 1000; //size of board width/height
  
  float seed = 3.14;

void setup() {
  //set canvas size
  size(1920,1080); //h: 2160
  
  //create instance of the simplex noise class
  //background(255); // reset screen
  noStroke();
  //noLoop(); //uncomment to only render one frame
}

//loop function that runs on a loop 
void draw() {
  seed+=.007;
  frames++;
  //clear(); // reset screen
  background(100); // reset screen

  float centerX = WIDTH/2;
  float centerY = HEIGHT/2;
  translate(centerX, centerY);

  drawBoard();
  
}

public void drawBoard() {
    fill(255);
    rect(-boardSz/2, -boardSz/2, boardSz, boardSz);

    boolean isWhite = true;
    
    fill(0);
    pushMatrix();
    
    translate(-boardSz/2, -boardSz/2);
    
    for (int i = 0; i < 8; ++i) {
      pushMatrix();
      for (int j = 0; j < 8; ++j) {
        if (!isWhite)
          rect(0,0, boardSz/8, boardSz/8);
        translate(boardSz/8, 0);
        isWhite = !isWhite;
      }
      popMatrix();
      translate(0, boardSz/8);
      isWhite = !isWhite;
    }
    popMatrix();
}
