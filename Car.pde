class Car {
  PImage img;
  float x;
  float y;
  float velocity;
  
  // function to set an image for the car
  void setImage(PImage image) {
    img = image;
  }

  // function to get the image of the car
  PImage getImage() {
    return img;
  }
  
  // function to move the car upwards based on the velocity
  void move(int direction) {
    switch(direction){
      case 0: 
        y-= velocity;
        break;
      case 1:
        x+= velocity;
        break;
      case 2:
        y+= velocity;
        break;
      case 3:
        x-= velocity;       
    }
  }
}
