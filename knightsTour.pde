/*
Stephen Burgess
 Knight's Tour Puzzle
 
 You must use move the knight so that it visits
 each square on the chessboard without visiting
 the same square more than once.
 
 You can find solutions here:
 http://en.wikipedia.org/wiki/Knight's_tour

 View online at:
 http://sburgess.us/knight.html
 */
 
int gridSize = 8; // Size of board in square units
int proportion = 50; // Size of square units in pixels
int xBox = 6, yBox = 0; // Starting Position 7/1
int positionX = xBox * proportion, positionY = yBox * proportion;

boolean[][] visited = new boolean[gridSize][gridSize];
boolean moreMoves = true, win = false;

int lastColor;

// Offset of Knight Image in Box
int knightOffsetX = 15;
int knightOffsetY = 10;

PImage knight;
PFont fontBig;

void setup() {
  // Sets canvas size by grid * grid unit size
  size(gridSize * proportion + 1, gridSize * proportion + 1);
  frameRate(15);
  background(#FFFFFF);
  smooth();
  ellipseMode(CENTER);
  
  fontBig = loadFont("DejaVuSans-72.vlw");
  textFont(fontBig);

  knight = loadImage("knight.png");

  // sets first square
  fill(#848F93);
  lastColor = #848F93;
  rect(positionX, positionY, proportion, proportion);
  image(knight, positionX + knightOffsetX, positionY + knightOffsetY);
  visited[xBox][yBox] = true;
} // end setup

void draw () {  
  drawBoard();

  if (!moreMoves) {  // if moreMoves == false from checkWin()
    if (!win) {      // fail
      fill(#EA9E4B);
      text("FAIL", width/2-75, height/2+25);
      noLoop();
    } 
    else {          // win
      fill(#FED4A5);
      text("You win!\nWow!\nAmazing!\nIncredible!", 10, 60);
      noLoop();
    }
  } // end if

  drawMouse();
} // end draw

/* each draw loop, this function
* checks each box to see if it has not
* already been visited. If it has not
* been visited, it colors it white or
* black to create the check pattern. 
*/
void drawBoard() {

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (!visited[i][j]) {
        if ((i % 2 != 0 && j % 2 == 0) // if i is odd and j is even
          || (i % 2 == 0 && j % 2 != 0)) { // or if i is even and j is odd
          fill(#FFFFFF);
        } 
        else { // if both i and j are even or odd
          fill(#000000);
        }
        rect(i*proportion, j*proportion, proportion, proportion);
      }
    }
  } // end board draw for loop

  // This draws the knight piece in the last selected location.
  image(knight, positionX + knightOffsetX, positionY + knightOffsetY);
} // end drawBoard

// Draws highlight for legal moves on mouseover
void drawMouse() {
  // creates dark blue highlight
  fill(#337893);

  int xOffset = 0;
  int yOffset = 0;

  /*
   * The coordinates of all possible knight moves
   * relative to the position of the knight.
   * pX and pY indicate the span offset of the grid spaces
   * described by relative position * proportion.
   *
   *  x  |   y       pX<  |   pX>       pY<   |   pY>
   * ------------    --------------    --------------
   *  2      1        3*p      2*p      2*p      1*p
   *  2     -1        3*p      2*p       0      -1*p
   * -2      1       -1*p     -2*p      2*p      1*p
   * -2     -1       -1*p     -2*p       0      -1*p
   *
   *  1      2        2*p      1*p      3*p      2*p
   *  1     -2        2*p      1*p     -1*p     -2*p
   * -1      2         0      -1*p      3*p      2*p
   * -1     -2         0      -1*p     -1*p     -2*p
   */

  for (int i = 2; i > -3; i--) {      // from 2 to -2
    if (i != 0) {                     // except 0
      for (int j = 2; j > -3; j--) {  // from 2 to -2
        if (j != 0) {                 // except 0
          /* if i is even and j is odd or
           * if i is odd and j is even
           * within the range of 2 and -2
           * excepting 0. In other words
           * the possible moves of the knight,
           * all positions that aren't directly
           * diagonal, horizontal, or vertical
           * from the starting position.
           */ 
          if ((i % 2 == 0 && j % 2 != 0) ||
              (i % 2 != 0 && j % 2 == 0)) {
            xOffset = i * proportion;
            yOffset = j * proportion;
      
            if (mouseX < positionX + xOffset + proportion && mouseX > positionX + xOffset // find mouseX
             && mouseY < positionY + yOffset + proportion && mouseY > positionY + yOffset // find mouseY
             // not necessary to prevent indexoutofbounds
             && !visited[xBox + i][yBox + j]) { // if relative position has not been visited
              rect(positionX + xOffset, positionY + yOffset, proportion, proportion);
              image(knight, positionX + xOffset + knightOffsetX, positionY + yOffset + knightOffsetY);
            }
          }
        }
      }
    }
  } // end for loop
} // end drawMouse

void mouseClicked() {

  int xOffset = 0;
  int yOffset = 0;

  for (int i = 2; i > -3; i--) {      // from 2 to -2
    if (i != 0) {                     // except 0
      for (int j = 2; j > -3; j--) {  // from 2 to -2
        if (j != 0) {                 // except 0
          /* if i is even and j is odd or
           * if i is odd and j is even
           * within the range of 2 and -2
           * excepting 0. In other words
           * the possible moves of the knight,
           * all positions that aren't directly
           * diagonal, horizontal, or vertical
           * from the starting position.
           */ 
          if ((i % 2 == 0 && j % 2 != 0) ||
              (i % 2 != 0 && j % 2 == 0)) {
            xOffset = i * proportion;
            yOffset = j * proportion;
          
            if (mouseX < positionX + xOffset + proportion && mouseX > positionX + xOffset
             && mouseY < positionY + yOffset + proportion && mouseY > positionY + yOffset
             && xBox + i >= 0 && xBox + i < gridSize && yBox + j >= 0 && yBox + j < gridSize
             // no need to prevent indexoutofbounds
             && !visited[xBox + i][yBox + j]) {
              
              // clears image from last selected location
              fill(lastColor);
              rect(positionX, positionY, proportion, proportion);
              
              // changes info to current location
              xBox += i;
              yBox += j;
              visited[xBox][yBox] = true;
              
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
            
              checkWin(); // checks for win or lose
            } 
          }
        }
      }
    }
  } // end main for loop
} // end mouseClicked


void checkWin() {
  // moreMoves will be false unless proven true
  moreMoves = false;
 
  for (int i = 2; i > -3; i--) { // from 2 to -2
    if (i != 0) { // except 0
      for (int j = 2; j > -3; j--) { // from 2 to -2
        if (j != 0) { // except 0
          if (((i % 2 == 0 && j % 2 != 0) || // if i is even and j is odd
               (i % 2 != 0 && j % 2 == 0)) && // or vice versa
                xBox + i >= 0 && xBox + i < gridSize && // i within bounds
                yBox + j >= 0 && yBox + j < gridSize && // j within bounds
               !visited[xBox+i][yBox+j]) { // not visited
            moreMoves = true; // there is still at least one possible move
          }
        }
      }
    }
  } // end moreMoves checking for loop

  if (!moreMoves) {
    // win will be true unless there is at least 
    // one box that has not been visited
    win = true;

    for (int i = 0; i < gridSize; i++) {   // Check all columns
      for (int j = 0; j < gridSize; j++) { // check all row units of each column
        if (!visited[i][j]) { // if even one location has not yet been visited
          win = false;        // player does not win
        }
      }
    } // end for loop
  } // end !moreMoves if 
} // end checkWin