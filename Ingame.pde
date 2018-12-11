class Ingame {
  void updateGame() {
    // Win condition
    if (car.y <= -20) {
      win();
    }

    // Use an int as a timer to prevent multiple collision checks on one tile
    if (collisionTimer <= 100) {
      collisionTimer++;
    }
    if (startCheck == true) {
      // TODO:: For (Car car : carList), loop through all the cars please
      if (destroyed) { 
        car.velocity = 0;
      } else {
        car.velocity = car.originalVelocity;
        car.rotate90();
      }
      car.CarCollision();
      car.move(previousDirection);
    }

    // Conditions to start the car and reset it.
    if (keysPressed[ENTER] == true && gameState == inGame) {
      startCheck = true;
    } else if (keysPressed['R'] == true) {
      car.y = height - 20;
      car.x = tileXStartRight + 25;
      previousDirection = 0;
      startCheck = false;
      destroyed = false;
      car.setImage(loadImage("images/carUp.png"));
      car.frame = 0;
    }
    Select();
  }

  void drawGame() {
    background(14, 209, 69); // make the background green

    // Draw the tiles and selector
    drawTilesLeft();
    drawTilesRight();
    if (startCheck == false) {
      if (Select) {
        selectLeft.drawSelect("left");
      } else {
        selectRight.drawSelect("right");
      }
    }


    // Play the car explosion animation
    if (destroyed) {
      car.destroy();
    }

    // Draw the finish line
    image(loadImage("images/finishline.png"), lineX, 0);

    // Draw the line seperating the line select and the play field
    line(lineX, 0, lineX, height);

    // Draw the car
    image(car.getImage(), car.x, car.y);

    if (win) {
      textSize(100);
      fill(255, 0, 0);
      text("YOU WIN!", width/2, height/2);
    }
  }

  // calls the select functions
  void Select() {
    if (Select) {
      if (keysPressed[' '] == true && limit == 0 && tilesLeft[selectLeft.tileNumber].select) {
        Select = false;
        limit = 1;
      } else {
        selectLeft.select(tileDistanceXLeft, tileXLeft, tileDistanceYLeft, tileYLeft, tileXStartLeft, tileRowLeft, tileCountLeft);
      }
    } else {
      if (keysPressed[' '] == true && limit == 0 && tilesRight[selectRight.tileNumber].select) {
        Select = true;
        limit = 1;
        Tile memory = tilesRight[selectRight.tileNumber];
        tilesRight[selectRight.tileNumber] = tilesLeft[selectLeft.tileNumber];
        tilesLeft[selectLeft.tileNumber] = memory;
      } else {
        selectRight.select(tileDistanceXRight, tileXRight, tileDistanceYRight, tileYRight, tileXStartRight, tileRowRight, tileCountRight);
      }
    }

    if (keysPressed[' '] == false) {
      limit = 0;
    }
  }
}
