class Menu {
  void drawMenu() {
     textSize(12);
     textAlign(LEFT);
     text("Press the arrow keys to move between menu options and tiles", 50, 600);
     text("Press SPACE to select menu options and tiles", 50, 625);
     text("Press ENTER to start the car ingame", 50, 650);
     text("Press R to return to the main menu", 50, 675);
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

    //Joey's abominatie
    if (keysPressed[RIGHT]) {
      testerinos = 2;
    }

    if (keysPressed[DOWN]) {
      testerinos = 1;
    }

    if (keysPressed[UP] ^ keysPressed[LEFT]) {
      testerinos = 0;
    }

    if (testerinos == 0) {
      image(loadImage("images/selectionFalse.png"), (width/2 - 50), (height/2) - 50);
      selectLevel = 1;
    } else if (testerinos == 1) {
      image(loadImage("images/selectionFalse.png"), (width/2 - 50), (height/2) + 150);
      selectLevel = 2;
    } else {
      selectLevel = 3;
      image(loadImage("images/selectionFalse.png"), (width/2) + 150, (height/2) - 50);
    }
  }

  void drawOptions() {

    background(101, 232, 255);
    textSize(30);
    text("MUTE SOUND", width/2, 3*(height/5));
    text("QUIT GAME", width/2, 4*(height/5));
  }
}
