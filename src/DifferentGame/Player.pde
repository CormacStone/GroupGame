class Player {
  int x, y, health, yspeed, xspeed, w, h;
  String State;

  Player(int x, int y) {
    this.x=x;
    this.y=y;
    xspeed= 5;
    w = 20;
    h = 20;
    yspeed= 5;
    fill(100);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
