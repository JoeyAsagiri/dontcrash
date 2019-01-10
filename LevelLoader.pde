class LevelLoader {

  // Loads an image, scans the pixels and fills an array based on the colors

  int[] loadLevel(PImage levelImage, int tileCount) {

    int levelArray[] = new int[tileCount];
    int arrayLocation = 0;

    // for each column in the image
    for (int iY = 0; iY<levelImage.height; iY++)
      // for each row in the image
      for (int iX = 0; iX<levelImage.width; iX++) {

        // check which color and fill in the correct tile in the array
        if  (levelImage.get(iX, iY) == tile1load) {
          levelArray[arrayLocation] = 1;
        } else if  (levelImage.get(iX, iY) == tile2load) {
          levelArray[arrayLocation] = 2;
        } else if  (levelImage.get(iX, iY) == tile3load) {
          levelArray[arrayLocation] = 3;
        } else if  (levelImage.get(iX, iY) == tile4load) {
          levelArray[arrayLocation] = 4;
        } else if  (levelImage.get(iX, iY) == tile5load) {
          levelArray[arrayLocation] = 5;
        } else if  (levelImage.get(iX, iY) == tile6load) {
          levelArray[arrayLocation] = 6;
        } else if  (levelImage.get(iX, iY) == tile7load) {
          levelArray[arrayLocation] = 7;
        } else if  (levelImage.get(iX, iY) == tile8load) {
          levelArray[arrayLocation] = 8;
        } else {
          levelArray[arrayLocation] = 8;
        }
        arrayLocation++;
      }
    return levelArray;
  }

  boolean[] loadSelect(PImage levelImage, int tileCount) {

    boolean levelArray[] = new boolean[tileCount];
    int arrayLocation = 0;
    // for each column in the image
    for (int iY = 0; iY<levelImage.height; iY++)
      // for each row in the image
      for (int iX = 0; iX<levelImage.width; iX++) {

        // check which color and fill in the correct tile in the array
        if  (levelImage.get(iX, iY) == tileSelectFalse) {
          levelArray[arrayLocation] = false;
        } else if  (levelImage.get(iX, iY) == tileSelectTrue) {
          levelArray[arrayLocation] = true;
        } else {
          levelArray[arrayLocation] = false;
        }
        arrayLocation++;
      }
    return levelArray;
  }

  boolean[] carLoad(PImage levelImage, int carAmount) {

    boolean[] carChecker = new boolean[carAmount];

    for (int iY = 0; iY<levelImage.height; iY++)
      for (int iX = 0; iX<levelImage.width; iX++) {
        if  (levelImage.get(iX, iY) == carSelectTrue) {
          carChecker[iX] = true;
        } else {
          carChecker[iX] = false;
        }
      }
    return carChecker;
  }



  void fillLevelList() {
          float positionHelper = 0;
    for (int i = 1; i <= levelAmount; i++) {
 
      if (positionHelper == 10){
      positionHelper = 0;
      }
      positionHelper++;


      float xPos = width/11 * positionHelper;
      float yPos;
      if (i<11) {
        yPos = height/2;
      } else if (i<20) {
        yPos = height/3*2;
      } else {
        yPos = height/4*3;
      }

      int[] leftTiles = levelLoader.loadLevel(loadImage("images/levels/level"+i+"links.png"), tileCountLeft);
      int[] rightTiles = levelLoader.loadLevel(loadImage("images/levels/level"+i+"rechts.png"), tileCountRight);
      boolean[] leftSelect = levelLoader.loadSelect(loadImage("images/selectcheck/level"+i+"links.png"), tileCountLeft);
      boolean[] rightSelect = levelLoader.loadSelect(loadImage("images/selectcheck/level"+i+"rechts.png"), tileCountRight);
      boolean[] carPositions = levelLoader.carLoad(loadImage("images/caramount/level"+i+".png"), maxCars);

      Levels level = new Levels(xPos, yPos, rightTiles, leftTiles, rightSelect, leftSelect, carPositions);

      levelsList.add(level);
    }
  }
}
