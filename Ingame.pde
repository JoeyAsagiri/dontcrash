class Ingame {

  // All the code that alters the Game World goes here
  void updateGame() {
    // Win condition

    if (startCheck == true) {
      for (Car car : carList) {
        // Use an int as a timer to prevent multiple collision checks on one tile
        if (car.collisionTimer <= 100) {
          car.collisionTimer++;
        }
        if (car.destroyed) {
          car.velocity = 0;
        } else {
          car.velocity = car.originalVelocity;
          car.rotate90();
        }
        car.CarCollision();
        car.move(car.previousDirection);
        carToCarCollision(car);
      }
      int j = 0;
      for (Car car : carList) {
        if (car.y <= -20)
          j++;
      }
      if (j == carList.length)
        win = true;
    }

    // Conditions to start the car and reset it.
    if (keysPressed[ENTER] == true && gameState == inGame) {
      startCheck = true;
    } else if (keysPressed['R'] == true) {
      int i = 0;
      for (Car car : carList) {
        switch (i) {
        case 0:
          car.carPosition(tileXStartRight + 25);
          break;
        case 1:
          car.carPosition(tileXStartRight + tileDistanceXRight + 25);
          break;
        case 2:
          car.carPosition(tileXStartRight + (tileDistanceXRight * 2) + 25);
          break;
        case 3:
          car.carPosition(tileXStartRight + (tileDistanceXRight * 3) + 25);
          break;
        }
        i++;
      }
      startCheck = false;
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
    for (Car car : carList) {
      if (car.destroyed) {
        car.destroy();
      }
    }

    // Draw the finish line
    image(loadImage("images/finishline.png"), lineX, 0);

    // Draw the line seperating the line select and the play field
    line(lineX, 0, lineX, height);

    // Draw the car
    for (Car car : carList) {
      image(car.getImage(), car.x, car.y);
    }

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
        if (keysPressed[' '] && !tilesLeft[selectLeft.tileNumber].select && limit == 0) {
          selectRight.reject.play();
          limit = 1;
        }
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
        if (keysPressed[' '] && !tilesRight[selectRight.tileNumber].select && limit == 0) {
          selectRight.reject.play();
          limit = 1;
        }
        selectRight.select(tileDistanceXRight, tileXRight, tileDistanceYRight, tileYRight, tileXStartRight, tileRowRight, tileCountRight);
      }
    }

    if (keysPressed[' '] == false) {
      limit = 0;
    }
  }
}
