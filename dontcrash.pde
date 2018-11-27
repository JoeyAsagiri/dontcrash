// Create a soundfile for the music  
import processing.sound.*;
SoundFile file;

// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;

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
SelectLeft selectLeft;
SelectRight selectRight;

final int tileXStartLeft = 50;
final int tileYStartLeft = 10;
final int tileXStartRight = 500;
final int tileYStartRight = 10;

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
int tileDistanceYRight = 200;

final int lineX = 400;

// constants for the car movement directions
final int up = 0;
final int right = 1;
final int down = 2;
final int left = 3;
int previousDirection = up;
int frame = 0;

int limit = 0;
int collisionTimer = 0;
int collisionAdjustment = 75;

void setup() {
  size(1280, 720);
  background(14, 209, 69); // make the background green

  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "/music/funky_theme.wav");
  file.loop();

  tilesLeft = initTiles(tileCountLeft); // Initialize the left side of the grid
  tilesRight = initTiles(tileCountRight);

  //Create the car
  car = new Car();

  car.setImage(loadImage("images/carUp.png"));
  car.x = tileXStartRight + 25;
  car.y = height - 20;
  car.velocity = 1.2;

  //Create the selector and give it the variables
  selectLeft = new SelectLeft();
  selectRight = new SelectRight();

  selectLeft.selectX = tileXLeft;
  selectLeft.selectY = tileYLeft;

  selectRight.selectX = tileXRight;
  selectRight.selectY = tileYRight;
}


void Select() {
  if (Select == true) {
    if (keysPressed[ENTER] == true && limit == 0) {
      Select = false;
      limit = 1;
    } else {
      selectLeft.selectLeft();
    }
  } else {
    if (keysPressed[ENTER] == true && limit == 0) {
      Select = true;
      limit = 1;
      Tile memory = tilesRight[selectRight.tileNumber];
      tilesRight[selectRight.tileNumber] = tilesLeft[selectLeft.tileNumber];
      tilesLeft[selectLeft.tileNumber] = memory;
    } else {
      selectRight.selectRight();
    }
  }

  if (keysPressed[ENTER] == false) {
    limit = 0;
  }
}

// Initialize a set amount of tiles and return an array of random tiles
Tile[] initTiles(int tileCountLeft) {
  tiles = new Tile[tileCountLeft];
  // Give an image and collision(?) to every tile
  for (int i = 0; i < tileCountLeft; i++) {
    float random = random(1, 9); // Get a random tile 
    tiles[i] = new Tile();
    tiles[i].setImage(loadImage("images/tiles/tile" + (int) random + ".png"));  //assign the image of the chosen tile to the tile
    tiles[i].setCollision((int) random); //set the collision of the chosen tile to the tile (todo)
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

//Collision checker

void CarCollision() {
  for (int i = 0; i < tilesRight.length; i++) {
    switch (previousDirection) {
    case up:
      if (car.x + car.width >= tilesRight[i].x && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth && car.y + car.height >= tilesRight[i].y && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight)
        collisionResult(tilesRight[i].getCollision());
      break;
    case right:
      if (car.x + car.width >= tilesRight[i].x + collisionAdjustment && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth + collisionAdjustment && car.y + car.height >= tilesRight[i].y && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight) 
        collisionResult(tilesRight[i].getCollision());
      break;
    case down:
      if (car.x + car.width >= tilesRight[i].x && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth && car.y + car.height >= tilesRight[i].y + collisionAdjustment && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight + collisionAdjustment)
        collisionResult(tilesRight[i].getCollision());
      break;
    case left:
      if (car.x <= lineX) {
        destroyed = true;
      }
      if (car.x + car.width >= tilesRight[i].x - (collisionAdjustment / 3) && car.x + car.width <= tilesRight[i].x + tilesRight[i].tileWidth - (collisionAdjustment / 3) && car.y + car.height >= tilesRight[i].y && car.y + car.height <= tilesRight[i].y + tilesRight[i].tileHeight) 
        collisionResult(tilesRight[i].getCollision());
      break;
    }
  }
}

void collisionResult(int[] tile) {
  switch(previousDirection) {
  case up:
    richting[0] = 2; 
    richting[1] = 0; 
    richting[2] = 1; 
    richting[3] = 3; 
    richting[4] = 0; 
    richting[5] = 1; 
    richting[6] = 3;
    collisionCalc(richting, tile);
    break;
  case right:
    richting[0] = 3; 
    richting[1] = 1; 
    richting[2] = 2; 
    richting[3] = 0; 
    richting[4] = 1; 
    richting[5] = 2; 
    richting[6] = 0;
    collisionCalc(richting, tile);
    break; 
  case down:
    richting[0] = 0; 
    richting[1] = 2; 
    richting[2] = 1; 
    richting[3] = 3; 
    richting[4] = 2; 
    richting[5] = 1; 
    richting[6] = 3;
    collisionCalc(richting, tile);
    break;
  case left:
    richting[0] = 1; 
    richting[1] = 3; 
    richting[2] = 2; 
    richting[3] = 0; 
    richting[4] = 3; 
    richting[5] = 2; 
    richting[6] = 0;
    collisionCalc(richting, tile);
  }
}

void collisionCalc(int[] richting, int[] tile ) {
  if (tile[richting[0]] == 1 ) {
    if (tile[richting[1]] == 1) {
      collisionTimer = 0;
      previousDirection = richting[4];
      print(previousDirection);
    } else if (tile[richting[2]] == 1) {
      collisionTimer = 0;
      previousDirection = richting[5];
      print(previousDirection);
    } else if (tile[richting[3]] == 1) {
      collisionTimer = 0;
      previousDirection = richting[6];
      print(previousDirection);
    }
  } else
    if (collisionTimer > 100) {
      destroyed = true;
    }
}



void rotate90() {
  switch(previousDirection) {
  case 0: 
    previousDirection = 0;
    car.setImage(loadImage("images/carUp.png"));
    break;
  case 1:
    previousDirection = 1;
    car.setImage(loadImage("images/carRight.png"));
    break;
  case 2:
    previousDirection = 2;
    car.setImage(loadImage("images/carDown.png"));
    break;
  case 3:
    previousDirection = 3;
    car.setImage(loadImage("images/carLeft.png"));
    break;
  }
}




// All the code that alters the Game World goes here
void updateGame() {
  if (collisionTimer <= 100) {
    collisionTimer++;
  }
  if (startCheck == true) {
    if (destroyed) { 
      car.velocity = 0;
    } else {
      car.velocity = 1.2;
      rotate90();
    }
    CarCollision();
    car.move(previousDirection);
  }
  if (keysPressed[BACKSPACE] == true) {
    startCheck = true;
  } else if (keysPressed[SHIFT] == true) {
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

// All the code that draws the Game World goes here
void drawGame() {
  background(14, 209, 69); // make the background green

  // Draw the tiles and selector

  drawTilesLeft();
  drawTilesRight();
  if (startCheck == false) {
    if (Select) {
      selectLeft.drawSelectLeft();
    } else {
      selectRight.drawSelectRight();
    }
  }


  // Play the car explosion animation
  if (destroyed) {
    car.destroy();
  }

  // Draw the line seperating the line select and the play field
  line(lineX, 0, lineX, height);

  // Draw the car
  image(car.getImage(), car.x, car.y);

  // Draw some placeholder text for the start and reset buttons
  fill(255, 0, 0);
  text("Press Enter to select and place tiles. Press backspace to start and press shift to reset", 800, 719);
} 

void draw() {
  updateGame(); // Update the game 
  drawGame();  // Draw the game
}

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
