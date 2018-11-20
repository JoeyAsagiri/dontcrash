public class Tile {

  int tileCountLeft = 8;
  int tileRowLeft = 2;
  int tileDistanceXLeft = 200;
  int tileDistanceYLeft = 200;

  int tileCountRight = 16;
  int tileRowRight = 4;
  int tileDistanceXRight = 200;
  int tileDistanceYRight = 200;

  final int tileXStartLeft = 50;
  final int tileYStartLeft = 10;
  final int tileXStartRight = 500;
  final int tileYStartRight = 10;

  int tileXLeft = tileXStartLeft;
  int tileYLeft = tileYStartLeft;
  int tileXRight = tileXStartRight;
  int tileYRight = tileYStartRight;

  int x;
  int y;
  PImage img;
  int[] collision = new int[4];

  final int tileWidth = 100;
  final int tileHeight = 100;

  void setImage(PImage image) {
    img = image;
  }

  PImage getImage() {
    return img;
  }

  // Set the collision by filling an array with 0 and 1 indicating each side if it's open or not, counting clockwise
  void setCollision(int random) {
    // TODO: fill in everything ffs
    switch (random) {
    case 1:  
      collision[0] = 1; 
      collision[1] = 0; 
      collision[2] = 1; 
      collision[3] = 0; //Straight line
      break;
    case 2: 
      collision[0] = 1; 
      collision[1] = 1; 
      collision[2] = 1; 
      collision[3] = 1; //Cross section
      break;
    case 3: 
      collision[0] = 0; 
      collision[1] = 1; 
      collision[2] = 1; 
      collision[3] = 0; //Right corner
      break;
    case 4: 
      collision[0] = 0; 
      collision[1] = 0; 
      collision[2] = 1; 
      collision[3] = 1; //Right corner
      break;
    case 5: 
      collision[0] = 0; 
      collision[1] = 1; 
      collision[2] = 0; 
      collision[3] = 1; //horizontal straight line
      break;
    case 6: 
      collision[0] = 1; 
      collision[1] = 0; 
      collision[2] = 0; 
      collision[3] = 1; //left to top corner
      break; 
    case 7: 
      collision[0] = 1; 
      collision[1] = 1; 
      collision[2] = 0; 
      collision[3] = 0; //right to top corner
      break;
    }
  }
  int[] getCollision() {
    return collision;
  }
}
