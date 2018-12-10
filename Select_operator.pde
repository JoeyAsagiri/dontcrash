class SelectOperator {
  
  boolean Select = true;
  SelectOperator(){
  
  //Create the selector and give it the variables
  selectLeft = new SelectLeft();
  selectRight = new SelectRight();

  selectLeft.selectX = tileXLeft;
  selectLeft.selectY = tileYLeft;

  selectRight.selectX = tileXRight;
  selectRight.selectY = tileYRight;
}

  // calls the right select function
  void Select() {
    if (Select) {
      if (keysPressed[' '] == true && limit == 0) {
        Select = false;
        limit = 1;
      } else {
        selectLeft.selectLeft();
      }
    } else {
      if (keysPressed[' '] == true && limit == 0) {
        Select = true;
        limit = 1;
        Tile memory = tilesRight[selectRight.tileNumber];
        tilesRight[selectRight.tileNumber] = tilesLeft[selectLeft.tileNumber];
        tilesLeft[selectLeft.tileNumber] = memory;
      } else {
        selectRight.selectRight();
      }
    }

    if (keysPressed[' '] == false) {
      limit = 0;
    }
  }
}
