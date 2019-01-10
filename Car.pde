class Car {
  PImage img;
  float x;
  float y;
  float velocity = 3;
  float originalVelocity = velocity;
  int frame = 0;
  boolean destroyed = false;
  int previousDirection = up;
  int collisionTimer = 0;
  boolean winCheck = false;
  SoundFile file;
  int number;

  //making the main menu fun to look at
  int directionMainMenu;
  boolean poof = false;

  final int width = 50;
  final int height = 80;

  Car() {
    img = loadImage("images/carUp.png");
  }

  // function to set an image for the car
  void setImage(PImage image) {
    img = image;
  }

  // function to get the image of the car
  PImage getImage() {
    return img;
  }

  // plays destruction-animation
  void destroy() {
    if (frame == 0) {
      file = new SoundFile(dontcrash.this, "/sound/explosion.wav");
      file.play();
    }
    if (frame < 20) {
      frame++;
      img = (loadImage("images/explosion/car"+(frame/4)+".png"));
      image(img, x - width / 2, y - height / 2);
    }
  }

  void carPosition(int positionX) {
    x = positionX;
    y = dontcrash.this.height - 20;
    destroyed = false;
    setImage(loadImage("images/carUp.png"));
    previousDirection = up;
    frame = 0;
  }

  //Collision checker
  void CarCollision() {
    for (int i = 0; i < tilesRight.length; i++) {
      switch (previousDirection) {

      case up:
        if (x + width >= tilesRight[i].x && x + width <= tilesRight[i].x + tilesRight[i].tileWidth && y + height >= tilesRight[i].y && y + height <= tilesRight[i].y + tilesRight[i].tileHeight)
          collisionResult(tilesRight[i].getCollision());
        break;

      case right:
        if (x + width >= tilesRight[i].x + collisionAdjustment && x + width <= tilesRight[i].x + tilesRight[i].tileWidth + collisionAdjustment && y + height >= tilesRight[i].y && y + height <= tilesRight[i].y + tilesRight[i].tileHeight) 
          collisionResult(tilesRight[i].getCollision());
        break;

      case down:
        if (x + width >= tilesRight[i].x && x + width <= tilesRight[i].x + tilesRight[i].tileWidth && y + height >= tilesRight[i].y + collisionAdjustment + (collisionAdjustment / 3) && y + height <= tilesRight[i].y + tilesRight[i].tileHeight + collisionAdjustment + (collisionAdjustment / 3))
          collisionResult(tilesRight[i].getCollision());
        break;

      case left:
        if (x <= lineX) {
          destroyed = true;
        }
        if (x + width >= tilesRight[i].x - (collisionAdjustment / 3) && x + width <= tilesRight[i].x + tilesRight[i].tileWidth - (collisionAdjustment / 3) && y + height >= tilesRight[i].y && y + height <= tilesRight[i].y + tilesRight[i].tileHeight) 
          collisionResult(tilesRight[i].getCollision());
        break;
      }
    }
  }

  // Calls collisionCalc with the right variables depending on direction of car
  void collisionResult(int[] tile) {
    switch(previousDirection) {
    case up:
      richting[0] = down; 
      richting[1] = up; 
      richting[2] = right; 
      richting[3] = left; 
      richting[4] = up; 
      richting[5] = right; 
      richting[6] = left;
      collisionCalc(richting, tile);
      break;

    case right:
      richting[0] = left; 
      richting[1] = right; 
      richting[2] = down; 
      richting[3] = up; 
      richting[4] = right; 
      richting[5] = down; 
      richting[6] = up;
      collisionCalc(richting, tile);
      break; 

    case down:
      richting[0] = up; 
      richting[1] = down; 
      richting[2] = right; 
      richting[3] = left; 
      richting[4] = down; 
      richting[5] = right; 
      richting[6] = left;
      collisionCalc(richting, tile);
      break;

    case left:
      richting[0] = right; 
      richting[1] = left; 
      richting[2] = down; 
      richting[3] = up; 
      richting[4] = left; 
      richting[5] = down; 
      richting[6] = up;
      collisionCalc(richting, tile);
    }
  }

  //Calculates what direction the car has to go
  void collisionCalc(int[] richting, int[] tile ) {
    // Check if the direction the car is entering the tile is open
    if (tile[richting[0]] == 1 ) {   
      // Check which way the car has to go depending on the tile
      if (tile[richting[1]] == 1) {      
        collisionTimer = 0;
        previousDirection = richting[4];
      } else if (tile[richting[2]] == 1) {
        collisionTimer = 0;
        previousDirection = richting[5];
      } else if (tile[richting[3]] == 1) {
        collisionTimer = 0;
        previousDirection = richting[6];
      }
    } else
    // destroy the car if the tile isn't open from the cars direction
      if (collisionTimer > (120 / originalVelocity)) {
        destroyed = true;
      }
  }


  // rotates the car on collision
  void rotate90() {
    switch(previousDirection) {
    case 0: 
      previousDirection = 0;
      setImage(loadImage("images/carUp.png"));
      break;
    case 1:
      previousDirection = 1;
      setImage(loadImage("images/carRight.png"));
      break;
    case 2:
      previousDirection = 2;
      setImage(loadImage("images/carDown.png"));
      break;
    case 3:
      previousDirection = 3;
      setImage(loadImage("images/carLeft.png"));
      break;
    }
  }


  // function to move the car based on the velocity
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
      break;
    case 4:
      velocity = 0;
      break;
    }
  }

  void carToCarCollision(Car car) {
    if (gameState == inGame) {
      for (Car car2 : carList) {
        if (x != car2.x) {
          if (x + width >= car2.x &&     // r1 right edge past r2 left
            x <= car2.x + car2.width &&       // r1 left edge past r2 right
            y + height >= car2.y &&       // r1 top edge past r2 bottom
            y <= car2.y + car2.height) {       // r1 bottom edge past r2 top
            destroyed = true;
            car2.destroyed = true;
          }
        }
      }
    } else if (gameState == mainMenu) {
      for (Car car2 : carListMenu) {
        if (x != car2.x) {
          if (x + width >= car2.x &&     // r1 right edge past r2 left
            x <= car2.x + car2.width &&       // r1 left edge past r2 right
            y + height >= car2.y &&       // r1 top edge past r2 bottom
            y <= car2.y + car2.height) {       // r1 bottom edge past r2 top
            poof = true;
            velocity = random (1, 5);
            car2.poof = true;
            car2.velocity = random (1, 5);
          }
        }
      }
    }
  }
}
