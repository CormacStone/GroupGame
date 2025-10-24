//Cormac Stone 
boolean l, r, u, d, lcol, rcol, ucol, dcol;
int x, y;
int nFloor;
Player player;
Map map;
void setup() {
  size(600, 600);
  //fullScreen();
  x = 100;
  y = 100;
}

void draw() {
  background(255);
  noStroke();
  rectMode(CORNER);
  map = new Map();
  map.drawMap();
  player = new Player(x, y);
  movement();
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
  if (!ucol) {
    if (u) {
      y-=player.yspeed;
    }
  }
  if (!dcol) {
    if (d) {
      y+=player.yspeed;
    }
    if (!d && !u) {
      y +=player.yspeed;
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
    //wy = (player.h/2);
  } else {
    ucol = false;
  }
  if (nFloor < player.h) {
    dcol = true;
  } else {
    dcol = false;
  }
  nFloor = 500-y;//(map.dval*map.cellSize)-y;
  println(map.dval);
  println(map.rval);
  println(map.lval);
  println(map.uval);
  println("player.x = " + player.x);
  println("player.y = " + player.y);
}
void keyPressed() {
  if (keyCode == 37 || key == 'a' || key == 'A') {
    l = true;
  }
  if (keyCode == 39 || key == 'd' || key == 'D') {
    r = true;
  }
  if (keyCode == 38 || key == 'w' || key == 'W') {
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
