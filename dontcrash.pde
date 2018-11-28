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

// constants for different screens
int gameState = 0;
final int mainMenu = 0;
final int levelSelect = 1;
final int options = 2;
final int inGame = 3;

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

final int position = 50;

// constants for the car movement directions
final int up = 0;
final int right = 1;
final int down = 2;
final int left = 3;
int previousDirection = up;
int frame = 0;

int limit = 0;
int bullshit = 0;

void setup() {
  size(1280, 720);
  background(101, 232, 255); // make the background blue

  tilesLeft = initTiles(tileCountLeft); // Initialize the left side of the grid
  tilesRight = initTiles(tileCountRight);

  //Create the car
  car = new Car();

  car.setImage(loadImage("images/car.png"));
  car.x = tileXStartRight + 25;
  car.y = 700;
  car.velocity = 1.2;

  //Create the selector and give it the variables
  selectLeft = new SelectLeft();
  selectRight = new SelectRight();

  selectLeft.selectX = tileXLeft;
  selectLeft.selectY = tileYLeft;
  selectLeft.tileCount = tileCountLeft;
  selectLeft.tileRow = tileRowLeft;
  selectLeft.tileDistanceX = tileDistanceXLeft;
  selectLeft.tileDistanceY = tileDistanceYLeft;
  selectLeft.tileNumber = 0;

  selectRight.selectX = tileXRight;
  selectRight.selectY = tileYRight;
  selectRight.tileCount = tileCountRight;
  selectRight.tileRow = tileRowRight;
  selectRight.tileDistanceX = tileDistanceXRight;
  selectRight.tileDistanceY = tileDistanceYRight;
  selectRight.tileNumber = 0;
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
      tilesRight[selectRight.tileNumber] = tilesLeft[selectLeft.tileNumber];
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
    float random = random(1, 8); // Get a random tile 
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

//Placeholder drawTilesRight
void drawTilesRight() {
  // Create tiles up to the tileCountLeft
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


void drawMainMenu() {
  
  
}


void drawOptions() {
  
}


void drawLevelSelect() {
  
}


// All the code that alters the Game World goes here
void updateGame() {
  bullshit++;
  if (startCheck == true) {
    if (destroyed) {
      car.velocity = 0;
    } else {
      car.velocity = 1.2;
    }
    CarCollision();
    car.move(previousDirection);
  }
  if (keysPressed[BACKSPACE] == true) {
    startCheck = true;
  } else if (keysPressed[SHIFT] == true) {
    car.y = 700;
    car.x = tileXStartRight + 25;
    previousDirection = 0;
    startCheck = false;
    destroyed = false;
    car.setImage(loadImage("images/car.png"));
    car.frame = 0;
  }
  Select();
  
}

//Collision checker

void CarCollision() {
  // adjust so going in from the top doesn't 
  for (int i = 0; i < tilesRight.length; i++) {
    if (car.x + 50 >= (tilesRight[i].x + 25) + 50 &&     // r1 right edge past r2 left
  car.x <= (tilesRight[i].x + 25) + 50  &&       // r1 left edge past r2 right
  car.y + 80 >= (tilesRight[i].y + 25) &&       // r1 top edge past r2 bottom
  car.y <= (tilesRight[i].y + 25)) {       // r1 bottom edge past r2 top
    collisionResult(tilesRight[i].getCollision());
}

    //if (car.x > tilesRight[i].x && car.x < tilesRight[i].x +100) {
    //  collisionResult(tilesRight[i].getCollision());
    //} 
    //else if (car.y > tilesRight[i].y && car.y < tilesRight[i].y +100) {
    //  collisionResult(tilesRight[i].getCollision());
    //}
  }
}


void collisionResult(int[] tile) {
  switch(previousDirection) {
    case 0:
    richting[0] = 2;
    richting[1] = 0;
    richting[2] = 1;
    richting[3] = 3;
    richting[4] = 0;
    richting[5] = 1;
    richting[6] = 3;
    collisionCalc(richting, tile);
    break;
    case 1:
    richting[0] = 3;
    richting[1] = 1;
    richting[2] = 2;
    richting[3] = 0;
    richting[4] = 1;
    richting[5] = 2;
    richting[6] = 0;
    collisionCalc(richting, tile);
    break; 
    case 2:
    richting[0] = 0;
    richting[1] = 2;
    richting[2] = 1;
    richting[3] = 3;
    richting[4] = 2;
    richting[5] = 1;
    richting[6] = 3;
    collisionCalc(richting, tile);
    break;
    case 3:
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
  if(tile[richting[0]] == 1 ) {
      if(tile[richting[1]] == 1) {
        bullshit = 0;
        previousDirection = richting[4];
        }
         else if(tile[richting[2]] == 1) {
           bullshit = 0;
           previousDirection = richting[5];
         }
         else if(tile[richting[3]] == 1){
           bullshit = 0;
           previousDirection = richting[6];
         }
    } else
    if(bullshit > 100) {
      car.destroy();
      destroyed = true;
    } 
}

// All the code that draws the Game World goes here
void drawGame() {
  background(101, 232, 255);

  // Draw the tiles and selector
  drawTilesLeft();
  drawTilesRight();

  if (Select) {
    selectLeft.drawSelectLeft();
  } else {
    selectRight.drawSelectRight();
  }

  // Draw the line seperating the line select and the play field
  line(400, 0, 400, 720);

  // Draw the car
  image(car.getImage(), car.x, car.y);
  
  // Draw some placeholder text for the start and reset buttons
  fill(255,0,0);
  text("Press Enter to select and place tiles. Press backspace to start and press shift to reset", 800,719);
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
