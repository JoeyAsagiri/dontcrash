class Car {
  PImage img;
  float x;
  float y;
  float velocity;
  float originalVelocity;
  int frame = 0;
  SoundFile file;

  final int width = 50;
  final int height = 80;

  Car() {
     velocity = 3; 
     originalVelocity = velocity;
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
    }
  }

//Collision checker
void CarCollision() {
  for (int i = 0; i < tilesRight.length; i++) {
    switch (previousDirection) {
      
    case up:
      if (car.x + car.width >= tilesRight[i].x && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth && car.y + car.height >= tilesRight[i].y && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight)
        collisionResult(tilesRight[i].getCollision());
      break;
      
    case right:
      if (car.x + car.width >= tilesRight[i].x + collisionAdjustment && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth + collisionAdjustment && car.y + car.height >= tilesRight[i].y && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight) 
        collisionResult(tilesRight[i].getCollision());
      break;
      
    case down:
      if (car.x + car.width >= tilesRight[i].x && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth && car.y + car.height >= tilesRight[i].y + collisionAdjustment + (collisionAdjustment / 3) && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight + collisionAdjustment + (collisionAdjustment / 3))
        collisionResult(tilesRight[i].getCollision());
      break;
      
    case left:
      if (car.x <= lineX) {
        destroyed = true;
      }
      if (car.x + car.width >= tilesRight[i].x - (collisionAdjustment / 3) && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth - (collisionAdjustment / 3) && car.y + car.height >= tilesRight[i].y && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight) 
        collisionResult(tilesRight[i].getCollision());
      break;
    }
  }
}

// Calls collisionCalc with the right variables depending on direction of car
void collisionResult(int[] tile) {
  switch(previousDirection) {
    
  case up:
    richting[0] = 2; 
    richting[1] = 0; 
    richting[2] = 1; 
    richting[3] = 3; 
    richting[4] = 0; 
    richting[5] = 1; 
    richting[6] = 3;
    collisionCalc(richting, tile);
    break;
    
  case right:
    richting[0] = 3; 
    richting[1] = 1; 
    richting[2] = 2; 
    richting[3] = 0; 
    richting[4] = 1; 
    richting[5] = 2; 
    richting[6] = 0;
    collisionCalc(richting, tile);
    break; 
    
  case down:
    richting[0] = 0; 
    richting[1] = 2; 
    richting[2] = 1; 
    richting[3] = 3; 
    richting[4] = 2; 
    richting[5] = 1; 
    richting[6] = 3;
    collisionCalc(richting, tile);
    break;
    
  case left:
    richting[0] = 1; 
    richting[1] = 3; 
    richting[2] = 2; 
    richting[3] = 0; 
    richting[4] = 3; 
    richting[5] = 2; 
    richting[6] = 0;
    collisionCalc(richting, tile);
  }
}

//Calculates what direction the car has to go
void collisionCalc(int[] richting, int[] tile ) {
  if (tile[richting[0]] == 1 ) {   
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
    if (collisionTimer > (100 / originalVelocity)) {
      destroyed = true;
    }
}


// rotates the car on collision
void rotate90() {
  switch(previousDirection) {
  case 0: 
    previousDirection = 0;
    car.setImage(loadImage("images/carUp.png"));
    break;
  case 1:
    previousDirection = 1;
    car.setImage(loadImage("images/carRight.png"));
    break;
  case 2:
    previousDirection = 2;
    car.setImage(loadImage("images/carDown.png"));
    break;
  case 3:
    previousDirection = 3;
    car.setImage(loadImage("images/carLeft.png"));
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
}
