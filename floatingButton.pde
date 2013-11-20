class floatingButton {
  int coordx;
  int coordy;
  float radius;
  String content;
  boolean touching;
  float innerCircleR;
  int timer;
  //constructor
  public floatingButton(int x, int y, int d, String s){
      coordx = x;
      coordy = y;
      radius = d/2;
      content = s;
      touching = false;
      timer = 0;
      innerCircleR=0;
  }
  //method to change the location of the button.
  public void setPosition(int x, int y){
      coordx = x;
      coordy = y;
  }
  //display the button on the screen
  public void display(){
      //draw two cricles
      ellipse(coordx,coordy,radius*2,radius*2);
      ellipse(coordx,coordy,innerCircleR*2,innerCircleR*2);
      //display text about button.
      //TODO change thick and color of text
      textAlign(CENTER);
      text(content, coordx,coordy+5);
      
  }
  //check if this button is being touched, if do, count for 3 sec and proceed function.
  void isTouched(int x, int y){
    float dist = sqrt((x-coordx)*(x-coordx)+(y-coordy)*(y-coordy));
    boolean newtouch = (dist<(radius));
    //check if given coords is in the area of button. 
    if(newtouch){
      if(touching==false){
        //if it start a touch,set timer
        timer = millis();
        touching = newtouch;
        // delay for 50ms
        }else if (millis()- timer > 50) {
          //draw a inner circle which will increase the radius by time.
          innerCircleR = innerCircleR + radius/60;
          this.display();  
          //if count time is up
          if (innerCircleR>radius){
            innerCircleR = radius;
          this.invoke();
          }         
        }
      
    }else{
      touching = newtouch;
    innerCircleR = 0;
    timer = 0;
    this.display();
    }
  }
  
  //function when this button been clicked.
  public void invoke(){}
}
