//Cormac Stone
boolean l, r, u, jAvail;  // movement keys
boolean onGround;
float gravity = 0.4;
float jumpForce = -12;
float camX = 0;
float camY = 0;
float camSmooth = 0.1;  // smaller = smoother
int currentLevel = 1;
Player player;
Map map;
Enemy guy;
Menu menu;
void setup() {
  jAvail = false;
  size(600, 600);
  //fullScreen();
  menu = new Menu();
  map = new Map(1 + ".csv");   // loads CSV or defaults if missing
  player = new Player(100, 100, 18, 80, 3); // (x, y, w, h, xspeed)
  guy = new Enemy(250, 250, 50, 50); // (x,y,w,h)
}

void draw() {
  background(255);
  // --- Smooth camera follow ---
  float targetCamX = constrain(player.x - width / 2, 0, map.cols * map.cellSize - width);
  float targetCamY = constrain(player.y - height / 2, 0, map.rows * map.cellSize - height);
  camX = lerp(camX, targetCamX, camSmooth);
  camY = lerp(camY, targetCamY, camSmooth);

  // --- Apply camera ---
  pushMatrix();
  translate(-camX, -camY);
  map.drawMap();
  player.display();
  player.handleMovement();
  guy.display();
  guy.move();
  popMatrix();
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
