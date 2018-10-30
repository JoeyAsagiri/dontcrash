// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

Tile[] tiles;
Tile[] tilesLeft;
Tile[] tilesRight;
Car car;
Select select;

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

int limit = 0;

void setup() {
  size(1280, 720);
  background(101, 232, 255); // make the background blue

  tilesLeft = initTiles(tileCountLeft); // Initialize the left side of the grid
  tilesRight = initTiles(tileCountRight);

  //Create the car
  car = new Car();

  car.setImage(loadImage("images/car.png"));
  car.x = 25 + position + (tileDistanceXLeft * 3);
  car.y = 700;
  car.velocity = 0.6;
  
  //Create the selector and give it the variables
  select = new Select();
  select.selectX = tileXLeft;
  select.selectY = tileYLeft;
  select.tileCount = tileCountLeft;
  select.tileRow = tileRowLeft;
  select.tileDistanceX = tileDistanceXLeft;
  select.tileDistanceY = tileDistanceYLeft;
}

// Initialize a set amount of tiles and return an array of random tiles
Tile[] initTiles(int tileCountLeft){
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
    rect(tileXRight, tileYRight, 150, 100);
    //image(tilesRight[i].getImage(), tileXRight, tileYRight);
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

// All the code that alters the Game World goes here
void updateGame() {
  car.move();
  select.select();
}

// All the code that draws the Game World goes here
void drawGame() {
  background(101, 232, 255);

  // Draw the tiles and selector
  drawTilesLeft();
  drawTilesRight();
  select.drawSelect();
  
  // Draw the line seperating the line select and the play field
  line(400, 0, 400, 720);
  
  // Draw the car
  image(car.getImage(), car.x, car.y);
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
  keysPressed[keyCode] = false;
}
