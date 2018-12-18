public class Levels {

  Levels(float x, float y, int[] conRightTiles, int[] conLeftTiles, boolean[] conRightSelect, boolean[] conLeftSelect, boolean[] conCarPositions) {
    xPos = x;
    yPos = y;
    rightTiles = conRightTiles;
    leftTiles = conLeftTiles;
    rightSelect = conRightSelect;
    leftSelect = conLeftSelect;
    carPositions = conCarPositions;
  }

  int[] rightTiles, leftTiles;
  boolean[] rightSelect, leftSelect, carPositions;
  float xPos, yPos;


  float getX() {
    return this.xPos;
  }

  float getY() {
    return this.yPos;
  }

  int[] getLeftTiles() {
    return this.leftTiles;
  }

  int[] getRightTiles() {
    return this.rightTiles;
  }

  boolean[] getLeftSelect() {
    return this.leftSelect;
  }

  boolean[] getRightSelect() {
    return this.rightSelect;
  }

  boolean[] getCarPositions() {
    return this.carPositions;
  }
ArrayList<Levels> levels = new ArrayList<Levels>();
{

  for (int i = 0; i < levelAmount; i++) {

    float positionHelper = i%10;

    xPos = positionHelper;

    if (i<10) {
      yPos = height/2;
    } else if (i<20) {
      yPos = height/3*2;
    } else {
      yPos = height/4*3;
    }

    leftTiles = levelLoader.loadLevel(loadImage("images/levels/level"+i+"links.png"), tileCountLeft);
    rightTiles = levelLoader.loadLevel(loadImage("images/levels/level"+i+"rechts.png"), tileCountRight);
    leftSelect = levelLoader.loadSelect(loadImage("images/selectcheck/level"+i+"links.png"), tileCountLeft);
    rightSelect = levelLoader.loadSelect(loadImage("images/selectcheck/level"+i+"rechts.png"), tileCountRight);
    carPositions = levelLoader.carLoad(loadImage("images/caramount/level"+i+".png"), maxCars);

    Levels level = new Levels(xPos, yPos, rightTiles, leftTiles, rightSelect, leftSelect, carPositions);

    levels.add(level);
  }
}
  
}
