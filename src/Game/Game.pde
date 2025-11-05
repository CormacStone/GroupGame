//Cormac Stone
boolean l, r, u, d, lcol, rcol, ucol, dcol, onG, jAvalible;
float x, y, vy, gravity, uForce;
float nFloor;
int mVar;
String placeHolder;
Player player;
Map map;
Boss boss;
void setup() {
  size(600, 600);
  fullScreen();
  x = 105;
  jAvalible = true;
  y = 110;
  mVar = 3;
}

void draw() {
  background(255);
  noStroke();
  rectMode(CORNER);
  if (mVar == 2) {
    map = new Map("2.csv");
  } else if (mVar == 3) {
    map = new Map("3.csv");
  } else {
    map = new Map();
  }
  map.drawMap();
  player = new Player(x, y);
  player.display();
  movement();
  boss = new Boss(100,100,20,20,placeHolder);
  gravity = 0.3;
  uForce = -player.yspeed;
  if ( vy < 5 ) vy += gravity;
  y += vy;
  frameRate(60);
  println(x);
  println(y);
}
void movement() {
  // --- HORIZONTAL MOVEMENT ---
  if (!lcol && l) x -= player.xspeed;
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
  lcol = false;
  rcol = false;

  // Predict next positions
  float nextXLeft = x - player.xspeed;
  float nextXRight = x + player.xspeed;

  // === LEFT SIDE CHECK ===
  {
  int leftCol = int((nextXLeft) / map.cellSize);
  int topRowLeft = int((y - player.h) / map.cellSize);
  int bottomRowLeft = int((y - 1) / map.cellSize);

  leftCol = constrain(leftCol, 0, map.cols - 1);
  topRowLeft = constrain(topRowLeft, 0, map.rows - 1);
  bottomRowLeft = constrain(bottomRowLeft, 0, map.rows - 1);

  for (int j = topRowLeft; j <= bottomRowLeft; j++) {
    if (map.map[leftCol][j].contains(3) || map.map[leftCol][j].contains(4)) {
      lcol = true;
      // snap player just to the right of this block
      x = (leftCol + 1) * map.cellSize;
      break;
    }
  }
}

// === RIGHT SIDE CHECK ===
{
int rightCol = int((nextXRight + player.w) / map.cellSize);
int topRowRight = int((y - player.h) / map.cellSize);
int bottomRowRight = int((y - 1) / map.cellSize);

rightCol = constrain(rightCol, 0, map.cols - 1);
topRowRight = constrain(topRowRight, 0, map.rows - 1);
bottomRowRight = constrain(bottomRowRight, 0, map.rows - 1);

for (int j = topRowRight; j <= bottomRowRight; j++) {
  if (map.map[rightCol][j].contains(3) || map.map[rightCol][j].contains(4)) {
    rcol = true;
    // snap player just to the left of this block
    x = (rightCol * map.cellSize) - player.w - 0.1;
    break;
  } else if (map.map[rightCol][j].contains(5)) {
    mVar +=1;
    break;
  }
}
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
