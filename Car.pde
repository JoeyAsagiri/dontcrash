class Car {
  PImage img;
  int frame;
  float x;
  float y;
  float velocity;

  // function to set an image for the car
  void setImage(PImage image) {
    img = image;
  }

  void destroy() { 
    if (frame < 20) {
      frame++;
      println(frame);
      img = (loadImage("images/eplosion/car"+(frame/4)+".png"));
    }
  }

  PImage getImage() {
    return img;
  }

  // function to move the car upwards based on the velocity
  void move(int direction) {
    switch(direction) {
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
