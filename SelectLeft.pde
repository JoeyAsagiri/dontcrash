class SelectLeft {
  int selectX, selectY;

  int tileCount;
  int tileRow;
  int tileDistanceX;
  int tileDistanceY;
  int tileNumber;

  // Function to move the selector over the tiles. 
  // TODO :: maybe find a better solution to the limit?
  void select() {
    if (keysPressed[RIGHT] && selectX != (tileDistanceX * (tileRow - 1) + 50) && limit == 0) {
      limit = 1;
      selectX = selectX + tileDistanceX;
      tileNumber = tileNumber+ 1;
    }
    if (keysPressed[LEFT] && selectX != tileXLeft && limit == 0) {
      limit = 1;
      selectX = selectX - tileDistanceX;
      tileNumber = tileNumber- 1;
    }
    if (keysPressed[DOWN] && selectY != (tileCount / tileRow -1)  * tileDistanceY + tileYLeft && limit == 0) {
      limit = 1;
      selectY = selectY + tileDistanceY;
      tileNumber = tileNumber+ 2;
    }
    if (keysPressed[UP] && selectY != tileYLeft && limit == 0) {
      limit = 1;
      selectY = selectY - tileDistanceY;
      tileNumber = tileNumber-2;
    }

    // prevent the selector from going super saiyan
    if (keysPressed[UP] == false && keysPressed[DOWN] == false && keysPressed[LEFT] == false && keysPressed[RIGHT] == false) {
      limit = 0;
    }

    // if enter is pressed, do stuff
    if (keysPressed[ENTER] == true) {
      //System.out.print(tileNumber);
      
    }
  }

  void drawSelectLeft() {
    image(loadImage("images/selection.png"), selectX, selectY);
  }
}
