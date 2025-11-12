// Kolby Green
class Menu {
  int x,y,w,h,inv;
  
  Menu() {
    x=width/2;
    y=height/2;
    w=250;
    h=750;
    this.inv = inv;
  }
  void display() {
    rect(x,y,w,h);
    println(inv);
  }
  void hover() {}
}
boolean isActive() {
  return true;
}
