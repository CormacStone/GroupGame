//Kolby Green + Maxwell Johnson
class Enemy {
   int x,y,w,h,xspeed;
   PImage guy;
  Enemy(int x, int y, int w, int h) {
    this.x=x;
    this.y=y;
    this.h=h;
    this.w=w;
    xspeed=5;
  }

  void display() {
    //rect(x, y, h, w);
    guy = loadImage("guy.png");
    guy.resize (w,h);
    image(guy,x,y);
  }
  
  void move() {
  PVector dude = new PVector(x,y);
  PVector them = new PVector (player.x,player.y);
  PVector move = PVector.sub(them,dude);
  move.normalize();
  move.mult(xspeed);
  x+=move.x;
  y+=move.y;
  }
}
