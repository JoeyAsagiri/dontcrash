class Car {
  PImage img;
  float x;
  float y;
  float velocity;
  int frame = 0;
  
  // function to set an image for the car
  void setImage(PImage image) {
    img = image;
  }

  // function to get the image of the car
  PImage getImage() {
    return img;
  }
  
  void destroy() { 
    if (frame < 20) {
      frame++;
      println(frame);
      img = (loadImage("images/explosion/car"+(frame/4)+".png"));
    }
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
        break;
      case 4:
        velocity = 0;
        break;
    }
  }
}
