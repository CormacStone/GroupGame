class Boss extends Enemy{
  
  
  Boss(int x,int y,int w,int h, String type){
    super(x,y,w,h,type);
    
  }
  void display(){
   rect(x,y,w,h); 
  }
}
