// ===========================================================
// MAIN SKETCH
// ===========================================================
// Cormac Stone — 2D Platformer Framework
// Compatible with your Map class
// ===========================================================

boolean l, r, u, jAvail;  // movement keys
boolean onGround;
float gravity = 0.4;
float jumpForce = -12;
float camX = 0;
float camY = 0;
float camSmooth = 0.1;  // smaller = smoother
int currentLevel;
Player player;
Map map;

void setup() {
  jAvail = false;
  size(600, 600);
  fullScreen();
  map = new Map(2 + ".csv");   // loads CSV or defaults if missing
  player = new Player(100, 100, 18, 18, 3); // (x, y, w, h, xspeed)
}

void draw() {
  background(255);

  handleMovement();

  // --- Smooth camera follow ---
  float targetCamX = constrain(player.x - width / 2, 0, map.cols * map.cellSize - width);
  float targetCamY = constrain(player.y - height / 2, 0, map.rows * map.cellSize - height);

  camX = lerp(camX, targetCamX, camSmooth);
  camY = lerp(camY, targetCamY, camSmooth);

  // --- Apply camera transform ---
  translate(-camX, -camY);

  map.drawMap(camX, camY);
  player.display();
}

void handleMovement() {
  float newX = player.x;
  float newY = player.y;

  // Horizontal movement
  if (l && !map.hasSolidToLeft(player.x, player.y, player.h)) {
    newX -= player.xspeed;
  }
  if (r && !map.hasSolidToRight(player.x, player.y, player.w, player.h)) {
    newX += player.xspeed;
  }

  // Apply gravity
  if (!onGround) player.vy += gravity;

  // Vertical movement
  newY += player.vy;

  // --- Floor collision ---
  onGround = false;
  int colLeft = int(newX / map.cellSize);
  int colRight = int((newX + player.w - 1) / map.cellSize);
  int bottomRow = int((newY + player.h) / map.cellSize);

  for (int c = colLeft; c <= colRight; c++) {
    if (map.isSolid(c, bottomRow)) {
      newY = bottomRow * map.cellSize - player.h; // snap to ground
      player.vy = 0;
      onGround = true;
      break;
    }
  }

  // --- Ceiling collision ---
  int topRow = int(newY / map.cellSize);
  for (int c = colLeft; c <= colRight; c++) {
    if (map.isSolid(c, topRow)) {
      newY = (topRow + 1) * map.cellSize;
      player.vy = 0;
    }
  }

  // --- Jumping ---
  if (u && onGround || jAvail) {
    player.vy = jumpForce;
    onGround = false;
    jAvail = false;
  }

  int playerColLeft = int(player.x / map.cellSize);
  int playerColRight = int((player.x + player.w - 1) / map.cellSize);
  int playerRow = int((player.y + player.h / 2) / map.cellSize);

  int leftTile = map.getTile(playerColLeft, playerRow);
  int rightTile = map.getTile(playerColRight, playerRow);

  if (leftTile == 5) loadNextMap(1);
  if (rightTile == 5) loadNextMap(2);


  // Commit updates
  player.x = newX;
  player.y = newY;
}
void loadNextMap(int i) {
  if (i == 1) currentLevel--;
  if (i == 2) currentLevel++;
  String nextMapFile = currentLevel + ".csv";
  println("Loading next map: " + nextMapFile);

  map = new Map(nextMapFile);

  // Reset player to start position
  player.x = 50;
  player.y = 50;
  player.vy = 0;

  // Reset camera too
  camX = 0;
  camY = 0;
}

void keyPressed() {
  if (key == 'a') l = true;
  if (key == 'd') r = true;
  if (key == 'w' || key == ' ') u = true;
}

void keyReleased() {
  if (key == 'a') l = false;
  if (key == 'd') r = false;
  if (key == 'w' || key == ' ') u = false;
}
