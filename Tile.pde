class Tile {
  PImage img;
  int[] collision = new int[4];
  
  void setImage(PImage image) {
    img = image;
  }

  PImage getImage() {
    return img;
  }
  
  // Set the collision by filling an array with 0 and 1 indicating each side if it's open or not, counting clockwise
  void setCollision(int random){
    switch (random) {
         case 1:  
           collision[0] = 1; collision[1] = 0; collision[2] = 1; collision[3] = 0; //Straight line
           break;
         case 2: 
           collision[0] = 1; collision[1] = 1; collision[2] = 1; collision[3] = 1; //Cross section
           break;
         case 3: 
           collision[0] = 0; collision[1] = 1; collision[2] = 1; collision[3] = 0; //Right corner
           break;
         case 4: 
           collision[0] = 0; collision[1] = 0; collision[2] = 1; collision[3] = 1; //Right corner
           break;
         case 5: 
           collision[0] = 0; collision[1] = 1; collision[2] = 0; collision[3] = 1; //horizontal straight line
           break;
         case 6: 
           collision[0] = 1; collision[1] = 0; collision[2] = 0; collision[3] = 1; //left to top corner
           break; 
         case 7: 
           collision[0] = 1; collision[1] = 1; collision[2] = 0; collision[3] = 0; //right to top corner
           break; 
    }
  }
  
  int[] getCollision(){
    return collision;
  }
}
