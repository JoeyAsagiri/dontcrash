class SelectRight {
  int selectX, selectY;

  int tileCount;
  int tileRow;
  int tileDistanceX;
  int tileDistanceY;
  int tileNumber;
  int limit = 0;

  // Function to move the selector over the tiles. 
  // TODO :: maybe find a better solution to the limit?
  void selectRight() {
    if (keysPressed[RIGHT] && selectX != (tileDistanceXRight * (tileRowRight - 1) + tileXStartRight) && limit == 0) {
      limit = 1;
      selectX = selectX + tileDistanceX;
      tileNumber = tileNumber+ 1;
    }
    if (keysPressed[LEFT] && selectX != tileXRight && limit == 0) {
      limit = 1;
      selectX = selectX - tileDistanceX;
      tileNumber = tileNumber- 1;
    }
    if (keysPressed[DOWN] && selectY != (tileCountRight / tileRowRight -1)  * tileDistanceYRight + tileYRight && limit == 0) {
      limit = 1;
      selectY = selectY + tileDistanceY;
      tileNumber = tileNumber+ 4;
    }
    if (keysPressed[UP] && selectY != tileYRight && limit == 0) {
      limit = 1;
      selectY = selectY - tileDistanceY;
      tileNumber = tileNumber-4;
    }

    // prevent the selector from going super saiyan
    if (keysPressed[UP] == false && keysPressed[DOWN] == false && keysPressed[LEFT] == false && keysPressed[RIGHT] == false && keysPressed[ENTER] == false) {
      limit = 0;
    }
  }

  void drawSelectRight() {
    image(loadImage("images/selection.png"), selectX, selectY);
  }
}
