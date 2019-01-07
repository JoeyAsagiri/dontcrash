// Create a soundfile for the music  
import processing.sound.*;
SoundFile file;

final color tile1load = color(255, 0, 0); //rood
final color tile2load = color(255, 106, 0); //oranje
final color tile3load = color(255, 216, 0); //geel
final color tile4load = color(0, 255, 33); //felgroen
final color tile5load = color(0, 255, 255); //felblauw
final color tile6load = color(0, 38, 255); //donkerblauw
final color tile7load = color(178, 0, 255); // paars
final color tile8load = color(0, 0, 0); // afro-amerikaans
final color tileSelectFalse = tile8load;
final color tileSelectTrue = color(255, 255, 255);
final color carSelectFalse = tileSelectFalse;
final color carSelectTrue = tileSelectTrue;

boolean Select = true;
boolean startCheck = false;

int[] richting = new int[7];
Tile[] tiles;
Tile[] tilesLeft;
Tile[] tilesRight;
Car[] car;
Car[] carList;
Car[] carListMenu;
int maxCars = 4;
Menu menu;
Timer timer;
Select selectLeft;
Select selectRight;
LevelLoader levelLoader;
Ingame ingame;
Levels levels;

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

int levelSelector = 0;
ArrayList<Levels> levelsList = new ArrayList<Levels>();
final int levelAmount = 10;

final int lineX = 400;

// Different screens
int gameState = 0;
final int mainMenu = 0;
final int levelSelect = 1;
final int optionsScreen = 2;
final int inGame = 3;

//settings?
int options;
boolean music;
int gameStateP = 0;
final int mainMenuP = 0;
final int levelSelectP = 1;
final int optionsScreenP = 2;
final int inGameP = 3;

// constants for the car movement directions
final int up = 0;
final int right = 1;
final int down = 2;
final int left = 3;
int frame = 0;

int limit = 0;
boolean limit2;
int limitRestart;

int collisionAdjustment = 75;

boolean win = false;

int[] levelLeft = new int[tileCountLeft];
int[] levelRight = new int[tileCountRight];
boolean[] levelLeftSelect = new boolean[tileCountLeft];
boolean[] levelRightSelect = new boolean[tileCountRight];
boolean[] carChecker = new boolean[maxCars];

boolean start = false;

int testerinos = 0;

int selectLevel = 0;

int selectMainMenu = 0;

int initialScore = 10000;
int moves = 0;

void setup() {

  // Initializeer klassen

  levelLoader = new LevelLoader();
  menu = new Menu();
  ingame = new Ingame();
  timer = new Timer();
  selectLeft = new Select();
  selectRight = new Select();
  selectLeft.selectX = tileXLeft;
  selectLeft.selectY = tileYLeft;
  selectRight.selectX = tileXRight;
  selectRight.selectY = tileYRight;
  carListMenu = menu.initCar();

  if (start) {
    // Initialize the left side of the grid
    tilesLeft = ingame.initTiles(tileCountLeft, levelsList.get(levelSelector).leftTiles, levelsList.get(levelSelector).leftSelect);
    tilesRight = ingame.initTiles(tileCountRight, levelsList.get(levelSelector).rightTiles, levelsList.get(levelSelector).rightSelect);
    carList = ingame.initCar(levelsList.get(levelSelector).carPositions);
  } else if (music == true) {
    file.stop();
  } else {
    // Load a soundfile from the /data folder of the sketch and play it back
    file = new SoundFile(dontcrash.this, "/music/funky_menu.wav");
    file.loop();
  }

  levelLoader.fillLevelList();

  startCheck = false;
  win = false;
  moves = 0;
  size(1280, 720);
}

// All the code that draws the Game World goes here
void draw() {
  timer.timeTrack();
  keyPresses();

  // handles drawing of different screens
  switch(gameState) {

  case mainMenu:
    menu.drawMainMenu();
    menu.drawMenu();
    break;

  case levelSelect:
    menu.drawLevelSelect();
    menu.drawMenu();
    break;

  case optionsScreen:
    menu.drawOptions();
    menu.drawMenu();
    break;

  case inGame:   
    ingame.updateGame();
    ingame.drawGame();
    break;
  }
}
