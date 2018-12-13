// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;

boolean[] keysPressed = new boolean[KEY_LIMIT];
boolean[] keysReleased = new boolean[KEY_LIMIT];

// Keyboard handling...
void keyPressed() {  
  if (keyCode >= KEY_LIMIT) return; //safety: if keycode exceeds limit, exit methhod ('return').
  keysPressed[keyCode] = true; // set its boolean to true
}

//..and with each key Released vice versa
void keyReleased() {
  if (keyCode >= KEY_LIMIT) return;
  keysPressed[keyCode] = false; // set its boolean to false
}

// Function to group a bunch of the key pressed features into one
void keyPresses() {

  // causes the screens to advance on buttonpresses
  if (!keysPressed[' ']) {
    limit2 = false;
    limit = 0;
  }

  //if (keysPressed['O'] && gameState == mainMenu) {
  //  gameState = optionsScreen;
  //}  

  //if (keysPressed[ENTER] && gameState == optionsScreen) {
  //  gameState = mainMenu;
  //} 

  //if (keysPressed[ENTER] && gameState == levelSelect) {
  //  gameState = mainMenu;
  //}

  if (keysPressed[' '] && gameState == mainMenu && limit2 == false) {
    gameState = levelSelect;
    limit2 = true;
  }

  if (!keysPressed[ENTER]) {
    limitRestart = 0;
  }

  if (keysPressed['R']) {
    file.stop();
    gameState = mainMenu;
    start = false;
    setup();
  }

  if (keysPressed[' '] && gameState == levelSelect && limit2 == false) {
    file.stop();
    // Load a soundfile from the /data folder of the sketch and play it back
    file = new SoundFile(dontcrash.this, "/music/funky_theme.wav");
    file.loop();
    // Prevent selector from immediately selecting the top left tile
    limit = 1;
    limit2 = true;

    gameState = inGame;
    start = true;

    levelLeft = levelLoader.loadLevel(loadImage("images/levels/level"+selectLevel+"links.png"), tileCountLeft);
    levelRight = levelLoader.loadLevel(loadImage("images/levels/level"+selectLevel+"rechts.png"), tileCountRight);
    levelLeftSelect = levelLoader.loadSelect(loadImage("images/selectcheck/level"+selectLevel+"links.png"), tileCountLeft);
    levelRightSelect = levelLoader.loadSelect(loadImage("images/selectcheck/level"+selectLevel+"rechts.png"), tileCountRight);
    carChecker = levelLoader.carLoad(loadImage("images/caramount/level"+selectLevel+".png"), maxCars);

    setup();
  }
}
