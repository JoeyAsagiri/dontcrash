class Menu {
  Car[] car;

  Car[] initCar() {
    int carAmount = 10;
    car = new Car[carAmount];
    for (int i = 0; i < carAmount; i++) {
      car[i] = new Car();
      car[i].directionMainMenu = Math.round(random(1, 4));
      switch (car[i].directionMainMenu) {
      case 1:
        car[i].x = random(width);
        car[i].y = height;
        car[i].velocity = random (1, 5);
        break;
      case 2:
        car[i].x = random(width);
        car[i].y = -100;
        car[i].velocity = random (1, 5);
        break;
      case 3:
        car[i].x = width;
        car[i].y = random(height);
        car[i].velocity = random (1, 5);
        break;
      case 4:
        car[i].x = -100;
        car[i].y = random(height);
        car[i].velocity = random (1, 5);
        break;
      }
    }
    return car;
  }


  void drawMenu() {
    textSize(12);
    textAlign(LEFT);
    text("Press the arrow keys to move between menu options and tiles", 50, 600);
    text("Press SPACE to select menu options and tiles", 50, 625);
    text("Press ENTER to start the car ingame", 50, 650);
    text("Press R to return to the main menu", 50, 675);
    if (options == 0 && music == false && gameState == optionsScreen) {
      text("Press left to turn music off", 50, 700);
    }
    if (options == 0 && music == true && gameState == optionsScreen) {
      text("Press right to turn music on", 50, 700);
    }
  }

  void drawMainMenu() {
    background(14, 209, 69);

    for (Car car : carListMenu) {

      switch (car.directionMainMenu) {
      case 1:
        car.y -= car.velocity;
        image(loadImage("images/carUp.png"), car.x, car.y);
        break;
      case 2:
        car.y += car.velocity;
        image(loadImage("images/carDown.png"), car.x, car.y);
        break;
      case 3:
        car.x -= car.velocity;
        image(loadImage("images/carLeft.png"), car.x, car.y);
        break;
      case 4:
        car.x += car.velocity;
        image(loadImage("images/carRight.png"), car.x, car.y);
        break;
      }

      switch (car.directionMainMenu) {
      case 1:
        if (car.y <= -100) {
          car.directionMainMenu = Math.round(random(1, 4));
          car.poof= true;
        }
        break;
      case 2:
        if (car.y >= height) {
          car.directionMainMenu = Math.round(random(1, 4));
          car.poof = true;
        }
        break;
      case 3:
        if (car.x <= -100) {
          car.directionMainMenu = Math.round(random(1, 4));
          car.poof = true;
        }
        break;
      case 4:
        if (car.x >= width) {
          car.directionMainMenu = Math.round(random(1, 4));
          car.poof = true;
        }
        break;
      }

      if (car.poof) {
        switch (car.directionMainMenu) {
        case 1:
          car.x = random(width);
          car.y = height;
          car.velocity = random (1, 5);
          car.poof = false;
          break;
        case 2:
          car.x = random(width);
          car.y = -100;
          car.velocity = random (1, 5);
          car.poof = false;
          break;
        case 3:
          car.x = width;
          car.y = random(height);
          car.velocity = random (1, 5);
          car.poof = false;
          break;
        case 4:
          car.x = -100;
          car.y = random(height);
          car.velocity = random (1, 5);
          car.poof = false;
          break;
        }
      }
      car.carToCarCollision(car);
    }

    textAlign(CENTER);
    textSize(100);
    text("DON'T CRASH", width/2, height/4); 
    fill(0, 102, 153);
    textSize(30);
    text("LEVEL SELECT", width/2, 3*(height/5));
    text("OPTIONS", width/2, 4*(height/5));

    if (selectMainMenu == 0 && gameState == mainMenu && keysPressed[DOWN]) {
      selectMainMenu = 1;
    }
    if (selectMainMenu == 1 && gameState == mainMenu && keysPressed[UP]) {
      selectMainMenu = 0;
    }

    if (selectMainMenu == 0 && gameState == mainMenu) {
      fill(255, 255, 255);
      text("LEVEL SELECT", width/2, 3*(height/5));
      fill(0, 102, 153);
    }
    if (selectMainMenu == 1 && gameState == mainMenu) {
      fill(255, 255, 255);
      text("OPTIONS", width/2, 4*(height/5));
      fill(0, 102, 153);
    }
    if (keysPressed[' '] && gameState == mainMenu && limit2 == false && selectMainMenu == 0) {
      gameState = levelSelect;
      limit2 = true;
    }

    if (keysPressed[' '] && gameState == mainMenu && limit2 == false && selectMainMenu == 1) {
      gameState = optionsScreen;
      limit2 = true;
    }
  }

  void drawLevelSelect() {
    background(101, 232, 255);
    textAlign(CENTER);
    textSize(100);
    text("LEVEL SELECT", width/2, height/4);
    textSize(24);

    //draws leveltexts
    for (int i = 0; i < levelAmount; i++) {
      text("Level "+(i+1), levelsList.get(i).xPos, levelsList.get(i).yPos);
    }


    //draws selector and makes variable to load in selected level
    if (levelSelector < 30) {
      if (keysPressed[RIGHT]) {

        levelSelector++;
        keysPressed[RIGHT] = false;
      }
    }
    
    if (levelSelector < 20) {
      if (keysPressed[DOWN]) {

        levelSelector += 10;
        keysPressed[DOWN] = false;
      }
    }

    if (levelSelector > 10) {
      if (keysPressed[UP]) {

        levelSelector -= 10;
        keysPressed[UP] = false;
      }
    }

    if (levelSelector > 0) {
      if (keysPressed[LEFT]) {

        levelSelector--;
        keysPressed[LEFT] = false;
      }
    }

    image(loadImage("images/selectionFalse.png"), (levelsList.get(levelSelector).xPos - 50), (levelsList.get(levelSelector).yPos - 50));
  }

  void drawOptions() {

    background(14, 209, 69);
    fill(0, 102, 153);
    textAlign(CENTER);
    textSize(30);
    text("QUIT GAME", width/2, 4*(height/5));

    // Sound
    if (options == 0) {
      fill(255, 255, 255);

      // Switches text based on if the music is turned on or off
      if (music == true) {
        text("SOUND OFF", width/2, 3*(height/5));
      } else if (music == false) {
        text("SOUND ON", width/2, 3*(height/5));
      }
      fill(0, 102, 153);
    }

    // Quit
    if (options == 1) {
      fill(0, 102, 153);
      text("SOUND ON/OFF", width/2, 3*(height/5));
      fill(255, 255, 255);
      text("QUIT GAME", width/2, 4*(height/5));
      fill(0, 102, 153);
    }

    // Press DOWN when 'Sound' is selected to move down
    if (keysPressed[DOWN] || (options == 2 && keysPressed[DOWN])) {
      options = 1;
    }

    // Press UP when 'quit' is selected to move up
    if ((options == 1) && (keysPressed[UP])) {
      options = 0;
    }

    // Press RIGHT to turn the music off
    if (options == 0 && keysPressed[RIGHT] && music == true) {
      file.loop();
      music = false;
    }

    // Press LEFT to turn the music on
    if (options == 0 && keysPressed[LEFT] && music == false) {
      file.stop();
      music = true;
    }

    // Press this option to exit the game
    if ((options == 1) && (keysPressed[' '])) {
      exit();
    }
  }
}
