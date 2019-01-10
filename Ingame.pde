class Ingame {

  // All the code that alters the Game World goes here
  void updateGame() {
    
    //timer.timeTrack();
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
      if (j == carList.length) {
        win();
      }
    }

    // Conditions to start the car and reset it.
    if (keysPressed[ENTER] == true && gameState == inGame && startCheck == false && limitRestart == 0) {
      startCheck = true;
      limitRestart = 1;
    } else if (keysPressed[ENTER] == true && limitRestart == 0 && !win) {
      for (Car car : carList) {
        switch (car.number) {
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
      }
      startCheck = false;
      limitRestart = 1;
    }

    if (!startCheck && !win)
      Select();
  }

  // Function to let the game go back to the menu when you win
  void win() {
    win = true;
    if (keysPressed[' '] == true) {
      file.stop();
      gameState = mainMenu;
      limit2 = true;
      file = new SoundFile(dontcrash.this, "/music/funky_menu.wav");
      if (music == true) {
        file.stop();
      }
      else {
        file.loop();
      }
      setup();
    }
  }

  // Function to draw everything in the level
  void drawGame() {
    background(14, 209, 69); // make the background green
    // Make the left select side grey
    fill(192, 192, 192);
    rect(0, 0, lineX , height - 1);

    // Draw the tiles and selector
    drawTiles(tilesLeft, tileCountLeft, tileRowLeft, tileXLeft, tileYLeft, tileDistanceXLeft, tileDistanceYLeft, tileXStartLeft, tileYStartLeft, false);
    drawTiles(tilesRight, tileCountRight, tileRowRight, tileXRight, tileYRight, tileDistanceXRight, tileDistanceYRight, tileXStartRight, tileYStartRight, true);
    //drawTilesLeft();
    //drawTilesRight();
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
      limit = 1;
      limit2 = true;
      textSize(100);
      textAlign(CENTER);
      fill(255, 0, 0);
      text("YOU WIN!", width/2, height/2);
      // disable the timer from changing after winning
      timer.running = false;
    }
    
    timer.displayTime();
  } 

  // calls the select functions
  void Select() {
    if (Select) {
      if (keysPressed[' '] == true && limit == 0 && tilesLeft[selectLeft.tileNumber].select) {
        Select = false;
        limit = 1;
        moves++;
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
        moves++;
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

  // Initialize a set amount of tiles and return an array of random tiles
  Tile[] initTiles(int tileCount, int[] level, boolean[] levelSelect) {
    tiles = new Tile[tileCount];
    // Give an image and to every tile
    for (int i = 0; i < tileCount; i++) {
      tiles[i] = new Tile();
      tiles[i].setImage(loadImage("images/tiles/" + tiles[i].rotatedTile(level[i]) + level[i] + ".png"));  //assign the image of the chosen tile to the tile
      tiles[i].setCollision(level[i]);
      tiles[i].select = levelSelect[i];
      tiles[i].tile = level[i];
    } 
    return tiles;
  }

  // Draw the tiles to be shown
  void drawTiles(Tile[] tiles, int tileCount, int tileRow, int tileX, int tileY, int tileDistanceX, int tileDistanceY, int tileXStart, int tileYStart, boolean sideRight) {

    // Create tiles up to the tileCountRight
    for (int i = 0; i < tileCount; i++) {
      // Don't draw obstacles on the left side
      if (sideRight || !sideRight && tiles[i].tile != 8) {
        image(tiles[i].getImage(), tileX, tileY);
      }
      tiles[i].x = tileX;
      tiles[i].y = tileY;
      tileX += tileDistanceX;

      // only place connection tiles on the right side of the field
      if (sideRight) {
        // Place a connection tile between this tile and the left tile if they connect properly
        if (i > 0 && (tiles[i].collision[left] == 1) && tiles[(i - 1)].collision[right] == 1 && ((i - 1) % tileRow == 0 || (i - 1) % tileRow == 1 || (i - 1) % tileRow == 2)) {
          image(loadImage("images/tiles/tile5.png"), tiles[i].x - 100, tiles[i].y);
        }
        // Place a connection tile between this tile and the tile above if they connect properly
        if (i >= tileRow && (tilesRight[i].collision[up] == 1) && tiles[(i - tileRow)].collision[down] == 1) {
          image(loadImage("images/tiles/tile1.png"), tiles[i].x, tiles[i].y - 100);
        }
      }

      // set the tiles another row down after every 4 tiles
      if ((i + 1) % tileRow == 0) {
        tileX = tileXStart;
        tileY += tileDistanceY;
      }
    } 
    tileX = tileXStart;
    tileY = tileYStart;
  }

  // Function to initialize all the cars for the level
  Car[] initCar(boolean[] carChecker) {
    int carAmount = 0;
    for (int i = 0; i < carChecker.length; i++) {
      if (carChecker[i]) {
        carAmount++;
      }
    }
    
    car = new Car[carAmount];
// Give an image and to every tile
    int carCount = 0;
    for (int i = 0; i < carChecker.length; i++) {
      
      if (carChecker[i] == true) {
        car[carCount] = new Car();
        switch (i) {
        case 0:
          car[carCount].carPosition(tileXStartRight + 25);
          break;
        case 1:
          car[carCount].carPosition(tileXStartRight + tileDistanceXRight + 25);
          break;
        case 2:
          car[carCount].carPosition(tileXStartRight + (tileDistanceXRight * 2) + 25);
          break;
        case 3:
          car[carCount].carPosition(tileXStartRight + (tileDistanceXRight * 3) + 25);
          break;
        }
        car[carCount].number = i;
        carCount++;
      }
    }
    return car;
  }

  // Function to check if a car has collision with another car
  void carToCarCollision(Car car) {
    for (Car car2 : carList) {
      if (car.x != car2.x) {
        if (car.x + car.width >= car2.x &&     // r1 right edge past r2 left
          car.x <= car2.x + car2.width &&       // r1 left edge past r2 right
          car.y + car.height >= car2.y &&       // r1 top edge past r2 bottom
          car.y <= car2.y + car2.height) {       // r1 bottom edge past r2 top
          car.destroyed = true;
          car2.destroyed = true;
        }
      }
    }
  }
}
