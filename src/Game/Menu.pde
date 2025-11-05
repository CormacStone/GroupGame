class Menu {
  int x,y,w,h;
  
  Menu() {
    x=width/2;
    y=height/2;
    w=25;
    h=75;
  }
  void display() {
    rect(x,y,w,h);
  }
  void hover() {}
}
