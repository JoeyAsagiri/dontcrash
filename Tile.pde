public class Tile {

  int x;
  int y;
  PImage img;
  int[] collision = new int[4];
  int tile;

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
    case 8: 
      collision[0] = 0; 
      collision[1] = 0; 
      collision[2] = 0; 
      collision[3] = 0; //blank tile
      break;
    }
  }
  int[] getCollision() {
    return collision;
  }

  // Functie om de blokade tiles random te draaien als het een blokade tile is
  String rotatedTile(int selectedTile) {
    String rotate = "tile";

    if (selectedTile == 8) {
      float random = random(1, 5);
      switch((int) random) {
      case 1:
        rotate = "hole";
        break;
      case 2:
        rotate = "rock";
        break;
      case 3:
        rotate = "thing";
      default:
        rotate = "tile";
        break;
      }
    }
    
    return rotate;
  }
}
