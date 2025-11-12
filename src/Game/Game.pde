//Cormac Stone
boolean l, r, u, jAvail;  // movement keys
boolean onGround;
float gravity = 0.4;
float jumpForce = -50;
float camX = 0;
float camY = 0;
float camSmooth = 0.1;  // smaller = smoother
int currentLevel = 4;
Player player;
Map map;
Menu menu;

void setup() {
  jAvail = false;
  size(600, 600);
  fullScreen();
  map = new Map(4 + ".csv");   // loads CSV or defaults if missing
  player = new Player(100, 100, 18, 18, 3); // (x, y, w, h, xspeed)
  menu = new Menu();
}

void draw() {
  background(255);



  // --- Smooth camera follow ---
  float targetCamX = constrain(player.x - width / 2, 0, map.cols * map.cellSize - width);
  float targetCamY = constrain(player.y - height / 2, 0, map.rows * map.cellSize - height);

  camX = lerp(camX, targetCamX, camSmooth);
  camY = lerp(camY, targetCamY, camSmooth);

  // --- Apply camera transform ---
  translate(-camX, -camY);
  map.drawMap(camX, camY);
  player.display();
  player.handleMovement();
}

void keyPressed() {
  if (key == 'a') l = true;
  if (key == 'd') r = true;
  if (key == 'w' || key == ' ') u = true;
  if (key == 'e') menu.display();
}

void keyReleased() {
  if (key == 'a') l = false;
  if (key == 'd') r = false;
  if (key == 'w' || key == ' ') u = false;
}
