// Create a soundfile for the music  
import processing.sound.*;
SoundFile file;

// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;

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


boolean[] keysPressed = new boolean[KEY_LIMIT];
boolean[] keysReleased = new boolean[KEY_LIMIT];

boolean Select = true;
boolean startCheck = false;
boolean destroyed = false;

int[] richting = new int[7];
Tile[] tiles;
Tile[] tilesLeft;
Tile[] tilesRight;
Car car;
Menu menu;
Select selectLeft;
Select selectRight;
Level level;
Ingame ingame;

final int tileXStartLeft = 50;
final int tileYStartLeft = 10;
final int tileXStartRight = 500;
final int tileYStartRight = 50;

int tileXLeft = tileXStartLeft;
int tileYLeft = tileYStartLeft;
int tileXRight = tileXStartRight;
int tileYRight = tileYStartRight;


//Grid
int tileCountLeft = 8;
int tileRowLeft = 2;
int tileDistanceXLeft = 200;
int tileDistanceYLeft = 200;

int tileCountRight = 16;
int tileRowRight = 4;
int tileDistanceXRight = 200;
int tileDistanceYRight = 180;

final int lineX = 400;


// Different screens
int gameState = 0;
final int mainMenu = 0;
final int levelSelect = 1;
final int optionsScreen = 2;
final int inGame = 3;


// constants for the car movement directions
final int up = 0;
final int right = 1;
final int down = 2;
final int left = 3;
int previousDirection = up;
int frame = 0;


int limit = 0;
boolean limit2;

int collisionTimer = 0;
int collisionAdjustment = 75;

boolean win = false;

int[] levelLeft = new int[tileCountLeft];
int[] levelRight = new int[tileCountRight];
boolean[] levelLeftSelect = new boolean[tileCountLeft];
boolean[] levelRightSelect = new boolean[tileCountRight];

boolean start = false;

int testerinos = 0;

int selectLevel = 0;



void setup() {

  // Initializeer de klassen
  level = new Level();
  menu = new Menu();
  ingame = new Ingame();

  size(1280, 720);

  // Initialize the left side of the grid
  if (start) {
    tilesLeft = initTiles(tileCountLeft, levelLeft, levelLeftSelect);
    tilesRight = initTiles(tileCountRight, levelRight, levelRightSelect);
  } else {
    // Load a soundfile from the /data folder of the sketch and play it back
    file = new SoundFile(this, "/music/funky_menu.wav");
    file.loop();
  }

  //Create the car
  car = new Car();

  // Zet de start positie van de auto TODO:: maak een nieuwe method om meerdere autos te maken met unieke posities
  car.x = tileXStartRight + 25;
  car.y = height - 20;

  //Create the selector and give it the variables
  selectLeft = new Select();
  selectRight = new Select();

  selectLeft.selectX = tileXLeft;
  selectLeft.selectY = tileYLeft;

  selectRight.selectX = tileXRight;
  selectRight.selectY = tileYRight;

  startCheck = false;
  win = false;
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
  } 
  return tiles;
}

// Draw the tiles to be shown
void drawTilesLeft() {

  // Create tiles up to the tileCountLeft
  for (int i = 0; i < tileCountLeft; i++) {
    image(tilesLeft[i].getImage(), tileXLeft, tileYLeft);
    tileXLeft += tileDistanceXLeft;

    // set the tiles another row down after every 2 tiles
    if ((i + 1) % tileRowLeft == 0) {
      tileXLeft = tileXStartLeft;
      tileYLeft += tileDistanceYLeft;
    }
  } 
  tileXLeft = tileXStartLeft;
  tileYLeft = tileYStartLeft;
}

// Draw the tiles to be shown
void drawTilesRight() {

  // Create tiles up to the tileCountRight
  for (int i = 0; i < tileCountRight; i++) {
    image(tilesRight[i].getImage(), tileXRight, tileYRight);
    tilesRight[i].x = tileXRight;
    tilesRight[i].y = tileYRight;
    tileXRight += tileDistanceXRight;

    // set the tiles another row down after every 4 tiles
    if ((i + 1) % tileRowRight == 0) {
      tileXRight = tileXStartRight;
      tileYRight += tileDistanceYRight;
    }
  } 
  tileXRight = tileXStartRight;
  tileYRight = tileYStartRight;
}

// Function to let the game go back to the menu when you win
void win() {
  win = true;
  if (keysPressed[' '] == true) {
    file.stop();
    gameState = mainMenu;
    limit2 = true;
    file = new SoundFile(this, "/music/funky_menu.wav");
    file.loop();
    setup();
  }
}

// All the code that draws the Game World goes here
void draw() {
  // causes the screens to advance on buttonpresses
  if (!keysPressed[' ']) {
    limit2 = false;
  }

  if (keysPressed[' '] && gameState == mainMenu) {
    gameState = levelSelect;
    limit2 = true;
  }

  if (keysPressed[' '] && gameState == levelSelect && limit2 == false) {
    file.stop();
    // Load a soundfile from the /data folder of the sketch and play it back
    file = new SoundFile(this, "/music/funky_theme.wav");
    file.loop();

    gameState = inGame;
    start = true;

    switch(selectLevel) {
    case 1:
      levelLeft = level.level1Links;
      levelRight = level.level1Rechts;
      levelLeftSelect = level.level1LinksSelect;
      levelRightSelect = level.level1RechtsSelect;
      break;
    case 2:
      levelLeft = level.level2Links;
      levelRight = level.level2Rechts;
      levelLeftSelect = level.level2LinksSelect;
      levelRightSelect = level.level2RechtsSelect;

    case 3:
      levelLeft = level.level3Links;
      levelRight = level.level3Rechts;
      levelLeftSelect = level.level3LinksSelect;
      levelRightSelect = level.level3RechtsSelect;
      break;
    }

    setup();
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

  // handles drawing of different screens

  switch(gameState) {

  case mainMenu:
    menu.drawMainMenu();
    break;

  case levelSelect:
    menu.drawLevelSelect();
    break;

  case optionsScreen:
    menu.drawOptions();
    break;

  case inGame:   
    ingame.updateGame();
    ingame.drawGame();
    break;
  }
}
