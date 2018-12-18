public class Levels {
  int[] rightTiles, leftTiles;
  boolean[] rightSelect, leftSelect, carPositions;
  float xPos, yPos;

  Levels(float x, float y, int[] conRightTiles, int[] conLeftTiles, boolean[] conRightSelect, boolean[] conLeftSelect, boolean[] conCarPositions) {
    xPos = x;
    yPos = y;
    rightTiles = conRightTiles;
    leftTiles = conLeftTiles;
    rightSelect = conRightSelect;
    leftSelect = conLeftSelect;
    carPositions = conCarPositions;
  }

}
