//Cormac Stone
boolean l, r, u, d, lcol, rcol, ucol, dcol, onG, jAvalible;
float x, y, vy, gravity, uForce;
float nFloor;
Player player;
Map map;
void setup() {
  size(600, 600);
  //fullScreen();
  x = 105;
  jAvalible = true;
  y = 110;
}

void draw() {
  background(255);
  noStroke();
  rectMode(CORNER);
  map = new Map();
  map.drawMap();
  player = new Player(x, y);
  movement();
  gravity = 0.3;
  uForce = -player.yspeed;
  if ( vy < 5 ) vy += gravity;
  y += vy;
  frameRate(60);
}
void movement() {
  // --- HORIZONTAL MOVEMENT ---
  if (!lcol && l)     x -= player.xspeed;
  if (!rcol && r) x += player.xspeed;
  // --- GRAVITY ---
  vy += gravity;
  y += vy;

  // --- FLOOR COLLISION ---
  int playerCol = int(x / map.cellSize);
  int bottomRow = map.getGroundBelowPlayer(playerCol); // get floor below player
  float floorY = bottomRow * map.cellSize;

  if (y >= floorY) {
    y = floorY; // snap exactly on top of the floor
    vy = 0;
    onG = true;
  } else onG = false;
  // --- CEILING COLLISION ---
  int topRow = int((y - player.h) / map.cellSize);
  if (topRow < 0) topRow = 0; // prevent out of bounds

  // check if block above player

  if (map.map[playerCol][topRow].contains(3) || map.map[playerCol][topRow].contains(4)) {
    y = (topRow + 1) * map.cellSize + player.h; // snap below block
    vy = 0;
    ucol = true;
  } else {
    ucol = false;
  }

  // --- LEFT/RIGHT COLLISIONS ---
  // --- Calculate player occupied columns/rows ---
  int playerTopRow = int((y - player.h) / map.cellSize);
  int playerBottomRow = int((y - 1) / map.cellSize);
  int leftCol = int((x - 1) / map.cellSize);
  int rightCol = int((x + player.w) / map.cellSize);

  // --- Constrain to map bounds ---
  leftCol = constrain(leftCol, 0, map.cols - 1);
  rightCol = constrain(rightCol, 0, map.cols - 1);
  playerTopRow = constrain(playerTopRow, 0, map.rows - 1);
  playerBottomRow = constrain(playerBottomRow, 0, map.rows - 1);


  // --- Side collisions ---
  lcol = false;
  rcol = false;
  for (int j = playerTopRow; j <= playerBottomRow; j++) {
    if (map.map[leftCol][j].contains(3) || map.map[leftCol][j].contains(4)) lcol = true;
    if (map.map[rightCol][j].contains(3) || map.map[rightCol][j].contains(4)) rcol = true;
  }




  // --- JUMP ---
  if (u && onG && jAvalible) {
    vy = uForce;
    onG = false;
    jAvalible = false;
  }
}

void keyPressed() {
  if (keyCode == 37 || key == 'a' || key == 'A') {
    l = true;
  }
  if (keyCode == 39 || key == 'd' || key == 'D') {
    r = true;
  }
  if (keyCode == 38 || key == 'w' || key == 'W' && onG) {
    u = true;
    jAvalible = true;
  }
  if (keyCode == 40 || key == 's' || key == 'S') {
    d = true;
  }
  //println(keyCode);
}
void keyReleased() {
  if (keyCode == 37 || key == 'a' || key == 'A') {
    l = false;
  }
  if (keyCode == 39 || key == 'd' || key == 'D') {
    r = false;
  }
  if (keyCode == 38 || key == 'w' || key == 'W') {
    u = false;
  }
  if (keyCode == 40 || key == 's' || key == 'S') {
    d = false;
  }
}
