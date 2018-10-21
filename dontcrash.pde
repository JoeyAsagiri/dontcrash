// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

Tile[] tiles;
Tile[] tilesLeft;
Tile[] tilesRight;
Car car;
Select select;

final int tileXStart = 50;
final int tileYStart = 10;
int tileX = tileXStart;
int tileY = tileYStart;

//Grid
int tileCount = 8;
int tileRow = 2;
int tileDistanceX = 200;
int tileDistanceY = 200;

final int position = 50;

int limit = 0;

void setup() {
  size(1280, 720);
  background(101, 232, 255); // make the background blue

  tilesLeft = initTiles(tileCount); // Initialize the left side of the grid

  //Create the car
  car = new Car();

  car.setImage(loadImage("images/car.png"));
  car.x = 25 + position + (tileDistanceX * 3);
  car.y = 700;
  car.velocity = 0.6;
  
  //Create the selector and give it the variables
  select = new Select();
  select.selectX = tileX;
  select.selectY = tileY;
  select.tileCount = tileCount;
  select.tileRow = tileRow;
  select.tileDistanceX = tileDistanceX;
  select.tileDistanceY = tileDistanceY;
}

// Initialize a set amount of tiles and return an array of random tiles
Tile[] initTiles(int tileCount){
  tiles = new Tile[tileCount];
   // Give an image and collision(?) to every tile
  for (int i = 0; i < tileCount; i++) {
    float random = random(1, 8); // Get a random tile 
    tiles[i] = new Tile();
    tiles[i].setImage(loadImage("images/tiles/tile" + (int) random + ".png"));  //assign the image of the chosen tile to the tile
    tiles[i].setCollision((int) random); //set the collision of the chosen tile to the tile (todo)
  } 
  return tiles;
}

// Draw the tiles to be shown
void drawTilesLeft() {
  // Create tiles up to the tileCount
  for (int i = 0; i < tileCount; i++) {
    image(tilesLeft[i].getImage(), tileX, tileY);
    tileX += tileDistanceX;
    // set the tiles another row down after every 2 tiles
    if ((i + 1) % tileRow == 0) {
      tileX = position;
      tileY += tileDistanceY;
    }
  } 
  tileX = tileXStart;
  tileY = tileYStart;
}

//Placeholder drawTilesRight
/*
void drawTiles() {
  // Create tiles up to the tileCount
  for (int i = 0; i < tileCount; i++) {
    image(tiles[i].getImage(), tileX, tileY);
    tileX += tileDistanceX;
    // set the tiles another row down after every 2 tiles
    if ((i + 1) % tileRow == 0) {
      tileX = position;
      tileY += tileDistanceY;
    }
  } 
  tileX = tileXStart;
  tile
*/

// All the code that alters the Game World goes here
void updateGame() {
  car.move();
  select.select();
}

// All the code that draws the Game World goes here
void drawGame() {
  background(101, 232, 255);

  // Draw the tiles and selector
  drawTiles();
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
