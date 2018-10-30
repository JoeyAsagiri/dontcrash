class Select {
  int selectX, selectY;
  
  int tileCount;
  int tileRow;
  int tileDistanceX;
  int tileDistanceY;

  // Function to move the selector over the tiles. 
  // TODO :: maybe find a better solution to the limit?
  void select() {
    if (keysPressed[RIGHT] && selectX != (tileDistanceX * (tileRow - 1) + 50) && limit == 0) {
      limit = 1;
      selectX = selectX + tileDistanceX;
    }
    if (keysPressed[LEFT] && selectX != tileXLeft && limit == 0) {
      limit = 1;
      selectX = selectX - tileDistanceX;
    }
    if (keysPressed[DOWN] && selectY != (tileCount / tileRow -1)  * tileDistanceY + tileYLeft && limit == 0) {
      limit = 1;
      selectY = selectY + tileDistanceY;
    }
    if (keysPressed[UP] && selectY != tileYLeft && limit == 0) {
      limit = 1;
      selectY = selectY - tileDistanceY; 
    }
    
    // prevent the selector from going super saiyan
    if (keysPressed[UP] == false && keysPressed[DOWN] == false && keysPressed[LEFT] == false && keysPressed[RIGHT] == false) {
      limit = 0;
    }
  }
  
  void drawSelect() {
    image(loadImage("images/selection.png"), selectX, selectY);   
  }
  
}
