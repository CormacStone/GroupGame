//Cormac Stone
boolean l, r, u, d, lcol, rcol, ucol, dcol, onG;
float x, y, vy, gravity, uForce;
float nFloor;
Player player;
Map map;
void setup() {
  size(600, 600);
  //fullScreen();
  x = 105;
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
  jump();
  gravity = 0.6;
  uForce = -12;
  vy += gravity;
  y += vy;
  frameRate(60);
}
void movement() {
  if (!lcol) {
    if (l) {
      x-=player.xspeed;
    }
  }
  if (!rcol) {
    if (r) {
      x+=player.xspeed;
    }
  }

  if (!dcol) {
    if (d) {
      y+=player.yspeed;
    }
  }
  //colision checks
  if (x<=player.w/2 ) {
    lcol= true;
  } else {
    lcol = false;
  }
  if (x>=width-player.w/2 ) {
    rcol = true;
  } else {
    rcol = false;
  }
  if (y<=(player.h/2)) {
    ucol = true;
  } else {
    ucol = false;
  }
  if (y >=480) {
    dcol = true;
    onG = true;
    vy = 0;
    y =490;
  } else {
    dcol = false;
  }
  nFloor = 500;
  println(map.dval);
  println(map.rval);
  println(map.lval);
  println(map.uval);
  println("player.x = " + player.x);
  println("player.y = " + player.y);
}
void jump() {
  if (u && onG) {
    vy = uForce;
    onG = false;
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
