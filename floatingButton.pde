class floatingButton {
  int coordx;
  int coordy;
  float radius;
  String content;
  boolean touching;
  float innerCircleR;
  int timer;
  
  public floatingButton(int x, int y, int d, String s){
      coordx = x;
      coordy = y;
      radius = d/2;
      content = s;
      touching = false;
      timer = 0;
      innerCircleR=0;
  }
  
  public void display(){
      ellipse(coordx,coordy,radius*2,radius*2);
      ellipse(coordx,coordy,innerCircleR*2,innerCircleR*2);
      
      textAlign(CENTER);
      text(content, coordx,coordy+5);
      
  }
  
  void isTouched(int x, int y){
    float dist = sqrt((x-coordx)*(x-coordx)+(y-coordy)*(y-coordy));
    boolean newtouch = (dist<(radius));
    if(newtouch){
      if(touching==false){
        timer = millis();
        touching = newtouch;
        }else if (millis()- timer > 50) {
          innerCircleR = innerCircleR + radius/120;
          this.display();  
          if (innerCircleR>radius){
            innerCircleR = radius;
          //TODO
          }         
        }
      
    }else{
      touching = newtouch;
    innerCircleR = 0;
    timer = 0;
    this.display();
    }
  }
}
