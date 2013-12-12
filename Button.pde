class Button {
  int coordx;
  int coordy;
  buttonGroup buttonGroup;
  float radius;
  String content;
  boolean touched;
  int timer;
  //constructor
  public Button(int x, int y, int r, String s){
      coordx = x;
      coordy = y;
      radius = r;
      content = s;
      touched = false;
      timer = 0;

  }
  //set the group this button belongs.
  public void setButtonGroup(buttonGroup bg){
  buttonGroup = bg;
  }
  public buttonGroup getButtonGroup(){
  return buttonGroup;
  }
  //method to change the location of the button.
  public void setPosition(int x, int y){
      coordx = x;
      coordy = y;
  }
  //display the button on the screen
  public void display(){
      //draw one cricles
      if ( (millis() - timer) < 200 ) {
        stroke(0, 255, 0);
      } else {
        stroke(255,255,255);
      }
      strokeWeight(3);
      noFill();
      ellipse(coordx,coordy,radius*2,radius*2);
  }
  //check if this button is being touched, if do, count for 3 sec and proceed function.
  void isTouched(int x, int y){
    float dist = sqrt((x-coordx)*(x-coordx)+(y-coordy)*(y-coordy));
    if(dist<(radius)){
      if(!touched  && ( millis()-timer > 200 )){
        this.invoke();
        touched = true;
      }
      
    }else{
    touched = false;
    }
  }
  
  //function when this button been clicked.
  public void invoke(){
    timer = millis();
  }
}
