class Car {
  PImage img;
  int frame;
  float x;
  float y;
  float velocity;
<<<<<<< HEAD

=======
  
  int Direction;
>>>>>>> 675441f56def320021699186e5b07f91a388a484
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
<<<<<<< HEAD

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
=======
  
 
  // function to move the car upwards based on the velocity
  void move(int direction) {
    switch(direction){
      case 0: 
        y-= velocity;
        Direction = direction;
        break;
      case 1:
        x+= velocity;
        Direction = direction;
        break;
      case 2:
        y+= velocity;
        Direction = direction;
        break;
      case 3:
        x-= velocity;  
        Direction = direction;
>>>>>>> 675441f56def320021699186e5b07f91a388a484
    }
  }
}
