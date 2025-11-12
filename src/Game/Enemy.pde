class Enemy {
   int x,y,w,h;
  Enemy(int x, int y, int h, int w, String type) {
    this.x=x;
    this.y=y;
    this.h=h;
    this.w=w;
  }

  void display() {
    rect(x, y, h, w);
    
  }
}
