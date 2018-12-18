class Menu {
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
    background(101, 232, 255);
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
    text("Level 1", width/2, height/2);
    text("Level 2", width/2, height/2 + 200);
    text("Level 3", width/2 + 200, height/2);
    text("Level 4", width/2 - 200, height/2);

    //Joey's abominatie
    if (keysPressed[RIGHT]) {
      testerinos = 2;
    }

    if (keysPressed[DOWN]) {
      testerinos = 1;
    }

    if (keysPressed[UP]) {
      testerinos = 0;
    }
    
    if (keysPressed[LEFT]) {
      testerinos = 3;
    }

    if (testerinos == 0) {
      image(loadImage("images/selectionFalse.png"), (width/2 - 50), (height/2) - 50);
      selectLevel = 1;
    } else if (testerinos == 1) {
      image(loadImage("images/selectionFalse.png"), (width/2 - 50), (height/2) + 150);
      selectLevel = 2;
    } else if (testerinos == 2){
      selectLevel = 3;
      image(loadImage("images/selectionFalse.png"), (width/2 + 150), (height/2) - 50);
    } else {
      selectLevel = 4; 
      image(loadImage("images/selectionFalse.png"), (width/2 - 250), (height/2) - 50);
    }
    timer.level = selectLevel;
  }

  void drawOptions() {

    background(101, 232, 255);
    fill(0, 102, 153);
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
