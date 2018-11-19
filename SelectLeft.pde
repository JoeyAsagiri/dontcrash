class SelectLeft {
  int selectX, selectY;

  int tileNumber = 0;
  int limit = 0;

  // Function to move the selector over the tiles. 
  // TODO :: maybe find a better solution to the limit?
  void selectLeft() {
    if (keysPressed[RIGHT] && selectX != (tileDistanceXLeft * (tileRowLeft - 1) + tileXStartLeft) && limit == 0) {
      limit = 1;
      selectX = selectX + tileDistanceXLeft;
      tileNumber = tileNumber+ 1;
    }
    if (keysPressed[LEFT] && selectX != tileXLeft && limit == 0) {
      limit = 1;
      selectX = selectX - tileDistanceXLeft;
      tileNumber = tileNumber- 1;
    }
    if (keysPressed[DOWN] && selectY != (tileCountLeft / tileRowLeft -1)  * tileDistanceYLeft + tileYLeft && limit == 0) {
      limit = 1;
      selectY = selectY + tileDistanceYLeft;
      tileNumber = tileNumber+ 2;
    }
    if (keysPressed[UP] && selectY != tileYLeft && limit == 0) {
      limit = 1;
      selectY = selectY - tileDistanceYLeft;
      tileNumber = tileNumber-2;
    }

    // prevent the selector from going super saiyan
    if (keysPressed[UP] == false && keysPressed[DOWN] == false && keysPressed[LEFT] == false && keysPressed[RIGHT] == false && keysPressed[ENTER] == false) {
      limit = 0;
    }
  }

  void drawSelectLeft() {
    image(loadImage("images/selection.png"), selectX, selectY);
  }
}
