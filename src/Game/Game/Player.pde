class Player {
  float x, y;
  float w, h;
  float xspeed;
  float vy; // vertical velocity

  Player(float x, float y) {
    this(x, y, 20, 20, 3);
  }

  Player(float x, float y, float w, float h, float xspeed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xspeed = xspeed;
    this.vy = 0;
  }

  void display() {
    fill(255, 0, 0);
    rect(x, y, w, h);
  }
}
