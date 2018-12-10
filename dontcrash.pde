// Create a soundfile for the music  
import processing.sound.*;
SoundFile file;
SoundFile file2;

boolean startCheck = false;

int[] richting = new int[7];
Tile[] tiles;
Tile[] tilesLeft;
Tile[] tilesRight;
SelectLeft selectLeft;
SelectRight selectRight;
Level level;
SelectOperator selectOperator;

final int tileXStartLeft = 50;
final int tileYStartLeft = 10;
final int tileXStartRight = 500;
final int tileYStartRight = 50;

int tileXLeft = tileXStartLeft;
int tileYLeft = tileYStartLeft;
int tileXRight = tileXStartRight;
int tileYRight = tileYStartRight;

//Create the car
Car car1 = new Car();
Car car2 = new Car();

void assignXAndY() {
  car1.x = tileXStartRight + 25;
  car1.y = height - 20;
  car2.x = tileXStartRight + 100;
  car2.y = height - 20;
}

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

boolean start = false;

int testerinos = 0;

int selectLevel = 0;

void setup() {  
  size(1280, 720);

  // Initializeer de level class zodat de arrays ook echt geladen worden ;p
  level = new Level();
  selectOperator = new SelectOperator();

  // Initialize the left side of the grid
  if (start) {
    car1.setImage(loadImage("images/carUp.png"));
    car2.setImage(loadImage("images/carUp.png"));
    tilesLeft = initTiles(tileCountLeft, level.level1Links);
    tilesRight = initTiles(tileCountRight, level.level1Rechts);
  } else {
    // Load a soundfile from the /data folder of the sketch and play it back
    file = new SoundFile(this, "/music/funky_menu.wav");
    file.loop();
  }

  startCheck = false;
  win = false;
}

// Initialize a set amount of tiles and return an array of random tiles
Tile[] initTiles(int tileCountLeft, int[] level) {
  tiles = new Tile[tileCountLeft];
  // Give an image and to every tile
  for (int i = 0; i < tileCountLeft; i++) {
    String tile = "tile";
    tiles[i] = new Tile();
    tiles[i].tile = level[i];
    if (level[i] == 8) {
      float random = random(1, 5);
      switch((int) random) {
      case 1:
        tile = "hole";
        break;
      case 2:
        tile = "rock";
        break;
      case 3:
        tile = "thing";
      case 4:
        tile = "tile";
        break;
      default:
        tile = "tile";
        break;
      }
    }
    tiles[i].setImage(loadImage("images/tiles/" + tile + level[i] + ".png"));  //assign the image of the chosen tile to the tile
    tiles[i].setCollision(level[i]); //set the collision of the chosen tile to the tile (todo)
  } 
  //for (int i = 0; i < tileCountLeft; i++) {
  //  float random = random(1, 9); // Get a random tile 
  //  tiles[i] = new Tile();
  //  tiles[i].setImage(loadImage("images/tiles/tile" + (int) random + ".png"));  //assign the image of the chosen tile to the tile
  //  tiles[i].setCollision((int) random); //set the collision of the chosen tile to the tile (todo)
  //} 
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


// All the code that alters the Game World goes here
void updateGame() {
  // Win condition
  if (car1.y <= -20 && car2.y <= -20) {
    win();
  }

  if (collisionTimer <= 100) {
    collisionTimer++;
  }
  
  if (startCheck == true) {
    if (car1.destroyed == true) {
        car1.velocity = 0;
      } else {
        car1.velocity = 20;
        car1.rotate90();
      }
      car1.CarCollision();
      car1.move(previousDirection);
    
    if (car2.destroyed == true){
        car2.velocity = 0;
      } else {
        car2.velocity = 20;
        car2.rotate90();
      }
      car2.CarCollision();
      car2.move(previousDirection);
  
  if (keysPressed[ENTER] == true && gameState == inGame) {
    startCheck = true;
  } else if (keysPressed['R'] == true) {
    car1.y = height - 20;
    car1.x = tileXStartRight + 25;
    car2.y = height - 20;
    car2.x = tileXStartRight + 100;
    previousDirection = 0;
    startCheck = false;
    car1.destroyed = false;
    car2.destroyed = false;
    car1.setImage(loadImage("images/carUp.png"));
    car2.setImage(loadImage("images/carUp.png"));
    car1.frame = 0;
    car2.frame = 0;
  }
  selectOperator.Select();
  }
}

// All the code that draws the Game World goes here

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
    image(loadImage("images/selection.png"), (width/2 - 50), (height/2) - 50);
    selectLevel = 1;
  } else if (testerinos == 1) {
    image(loadImage("images/selection.png"), (width/2 - 50), (height/2) + 150);
    selectLevel = 2;
  } else {
    selectLevel = 3;
    image(loadImage("images/selection.png"), (width/2) + 150, (height/2) - 50);
  }
}


void drawOptions() {

  background(101, 232, 255);
  textSize(30);
  text("MUTE SOUND", width/2, 3*(height/5));
  text("QUIT GAME", width/2, 4*(height/5));
}

void drawGame() {
  background(14, 209, 69); // make the background green

  // Draw the tiles and selector

  drawTilesLeft();
  drawTilesRight();
  if (startCheck == false) {
    if (selectOperator.Select) {
      selectLeft.drawSelectLeft();
    } else {
      selectRight.drawSelectRight();
    }
  }


  // Play the car explosion animation
  if (car1.destroyed) {
    car1.destroy();
  }

  if (car2.destroyed) {
    car2.destroy();
  }

  // Draw the finish line
  image(loadImage("images/finishline.png"), lineX, 0);

  // Draw the line seperating the line select and the play field
  line(lineX, 0, lineX, height);

  // Draw the car
  image(car1.getImage(), car1.x, car1.y);

  // Draw the car
  image(car2.getImage(), car2.x, car2.y);

  //// Draw some placeholder text for the start and reset buttons
  //fill(255, 0, 0);
  //textSize(11);
  //text("Press Enter to select and place tiles. Press backspace to start and press shift to reset", 1050, 719);

  if (win) {
    textSize(100);
    fill(255, 0, 0);
    text("YOU WIN!", width/2, height/2);
  }
} 

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

    //switch(selectLevel) {
    //case 1:
    //  level.levelLeft = level.level1Links;
    //  level.levelRight = level.level1Rechts;
    //  break;
    //case 2:
    //  level.levelLeft = level.level2Links;
    //  level.levelRight = level.level2Rechts;
    //case 3:
    //  level.levelLeft = level.level3Links;
    //  level.levelRight = level.level3Rechts;
    //  break;
    //}

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
  updateGame();
  switch(gameState) {

  case mainMenu:
    drawMainMenu();
    break;

  case levelSelect:
    drawLevelSelect();
    break;

  case optionsScreen:
    drawOptions();
    break;

  case inGame:   
    drawGame();
    break;
  }
}
