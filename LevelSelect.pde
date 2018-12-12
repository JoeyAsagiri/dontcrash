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
}
