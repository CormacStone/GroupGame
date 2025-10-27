class Player {
  int health, yspeed, xspeed, w, h;
  String State;
  float x ,y;
  Player(float x, float y) {
    this.x=x;
    this.y=y;
    xspeed= 10;
    w = 20;
    h = 20;
    yspeed= 10;
    fill(100);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
