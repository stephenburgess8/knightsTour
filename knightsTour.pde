/*
Stephen Burgess
 Knight's Tour Puzzle
 
 You must use move the knight so that it visits
 each square on the chessboard without visiting
 the same square more than once.
 
 You can find solutions here:
 http://en.wikipedia.org/wiki/Knight's_tour
 */
 
int gridSize = 8; // Size of board in square units
int proportion = 50; // Size of square units in pixels
int xBox = 6, yBox = 0; // Starting Position
int positionX = xBox * proportion, positionY = yBox * proportion;

boolean[][] boxes = new boolean[gridSize][gridSize];
boolean noMoreMoves = false, win = false;

int lastColor = #848F93;

// Offset of Knight Image in Box
int knightOffsetX = 15;
int knightOffsetY = 10;

PImage knight;
PFont fontBig;

void setup() {
  size(gridSize * proportion + 1, gridSize * proportion + 1);
  background(#FFFFFF);
  stroke(0);
  smooth();
  ellipseMode(CENTER);
  
  fontBig = loadFont("DejaVuSans-72.vlw");
  textFont(fontBig);

  knight = loadImage("knight.png");

  // sets first square
  fill(#848F93);
  rect(positionX, positionY, proportion, proportion);
  image(knight, positionX + knightOffsetX, positionY + knightOffsetY);
  boxes[xBox][yBox] = true;
}

void draw () {
 /* each draw loop, this for statement
  * checks each box to see if it has not
  * already been visited. If it has not
  * been visited, it colors it white or
  * black to create the check pattern. 
  */
  
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (!boxes[i][j]) {
        if ((i % 2 != 0 && j % 2 == 0)
          || (i % 2 == 0 && j % 2 != 0)) {
          fill(#FFFFFF);
        } 
        else {
          fill(#000000);
        }
        rect(i*proportion, j*proportion, proportion, proportion);
      }
    }
  }
  
  // This loads the image of the knight piece
  // in the last selected location.
  image(knight, positionX + knightOffsetX, positionY + knightOffsetY);
  
  // if fail == true from checkWin()
  if (noMoreMoves) {
    if (!win) { // fail
      fill(#EA9E4B);
      text("FAIL", width/2-75, height/2+25);
      noLoop();
    } 
    else { // if win == true from checkWin()
      fill(#FED4A5);
      text("You win!\nWow!\nAmazing!\nIncredible!", 10, 60);
      noLoop();
    }
  }
  
  // creates dark blue highlight
  fill(#337893);

  /*
     x  |   y       pX<  |   pX>       pY<   |   pY>
    ------------    --------------    --------------
     2      1        3*p      2*p      2*p      1*p
     2     -1        3*p      2*p       0      -1*p
    -2      1       -1*p     -2*p      2*p      1*p
    -2     -1       -1*p     -2*p       0      -1*p
  
     1      2        2*p      1*p      3*p      2*p
     1     -2        2*p      1*p     -1*p     -2*p
    -1      2         0      -1*p      3*p      2*p
    -1     -2         0      -1*p     -1*p     -2*p
  */

  int xOffset = 0;
  int yOffset = 0;

  // from 2 to -2 except 0
  for (int i = 2; i > -3; i--) {
    // from 2 to -2 except 0
    if (i != 0) {
      for (int j = 2; j > -3; j--) {
        if (j != 0) {
          if ((i % 2 == 0 && j % 2 != 0) ||
              (i % 2 != 0 && j % 2 == 0)) {
            xOffset = i * proportion;
            yOffset = j * proportion;
      
            if (mouseX < positionX + xOffset + proportion && mouseX > positionX + xOffset
              && mouseY < positionY + yOffset + proportion && mouseY > positionY + yOffset
              && xBox + i >= 0 && xBox + i < gridSize
              && yBox + j >= 0 && yBox + j < gridSize
              && !boxes[xBox + i][yBox + j]) {
              stroke(0);
              rect(positionX + xOffset, positionY + yOffset, proportion, proportion);
              image(knight, positionX + xOffset + knightOffsetX, positionY + yOffset + knightOffsetY);
            }
          }
        }
      }
    }
  }
}



void mouseClicked() {

  int xOffset = 0;
  int yOffset = 0;

  // from 2 to -2 except 0
  for (int i = 2; i > -3; i--) {
    if (i != 0) {
      // from 2 to -2 except 0
      for (int j = 2; j > -3; j--) {
        if (j != 0) {
          if ((i % 2 == 0 && j % 2 != 0) ||
              (i % 2 != 0 && j % 2 == 0)) {
              xOffset = i * proportion;
              yOffset = j * proportion;
            
              if (mouseX < positionX + xOffset + proportion && mouseX > positionX + xOffset
               && mouseY < positionY + yOffset + proportion && mouseY > positionY + yOffset
               && xBox + i >= 0 && xBox + i < gridSize && yBox + j >= 0 && yBox + j < gridSize
               && !boxes[xBox + i][yBox + j]) {
                
                // clears image from last selected location
                fill(lastColor);
                rect(positionX, positionY, proportion, proportion);
                
                // changes info to current location
                xBox += i;
                yBox += j;
                boxes[xBox][yBox] = true;
                
                
                positionX = xBox * proportion;
                positionY = yBox * proportion;
                
                // makes highlighted blue color
                // dependent on if the location
                // is white or black to begin with
                if ((xBox % 2 != 0 && yBox % 2 == 0) ||
                    (xBox % 2 == 0 && yBox % 2 != 0)) {
                  fill(#A7E5FC);
                  rect(positionX, positionY, proportion, proportion);
                  lastColor = #D5EDED;
                }
                else {
                  fill(#337893);
                  rect(positionX, positionY, proportion, proportion);
                  lastColor = #848F93;
                } 
                // checks for win or lose
                checkWin();
              }
            }
        }
      }
    }
  }
}


void checkWin() {
  // fail will be true unless
  // proven otherwise
  noMoreMoves = true;

  // from 2 to -2 except 0
  for (int i = 2; i > -3; i--) {
    if (i != 0) {
      // from 2 to -2 except 0
      for (int j = 2; j > -3; j--) {
        if (j != 0) {
          // if i is even and j is odd or vice versa
          if ((i % 2 == 0 && j % 2 != 0) || 
              (i % 2 != 0 && j % 2 == 0)) {
            if (xBox + i >= 0 && xBox + i < gridSize &&
                yBox + j >= 0 && yBox + j < gridSize &&
                !boxes[xBox+i][yBox+j]) {
              noMoreMoves = false;
            }
          }
        }
      }
    }
  }

  if (noMoreMoves) {
    // win will be true unless
    // there is at least one box
    // that has not been visited
    win = true;

    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (!boxes[i][j]) {
          win = false;
        }
      }
    }
  }
}

