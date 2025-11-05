class Player {
  int health, yspeed, xspeed, w, h;
  String State;
  float x, y;
  Player(float x, float y) {
    this.x=x;
    this.y=y;
    xspeed= 4;
    w = 20;
    h = 20;
    yspeed= 10;
    fill(100);
  }

  void display() {
    rectMode(CORNER);
    rect(x, y-20, w, h);
  }
}
