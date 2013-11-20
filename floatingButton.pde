class floatingButton {
  int coordx;
  int coordy;
  int user;
  float radius;
  String content;
  boolean touched;
  float innerCircleR;
  int timer;
  //constructor
  public floatingButton(int x, int y, int d, String s){
      coordx = x;
      coordy = y;
      radius = d/2;
      content = s;
      touched = false;
      timer = 0;
      innerCircleR=0;
  }
  public void setUser(int u){
  user = u;
  }
  //method to change the location of the button.
  public void setPosition(int x, int y){
      coordx = x;
      coordy = y;
  }
  //display the button on the screen
  public void display(){
      //draw two cricles
      strokeWeight(3);
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
    if(dist<(radius)){
      if(!touched){
        this.invoke();
        touched = true;
      }
      
    }else{
    touched = false;
    }
  }
  
  //function when this button been clicked.
  public void invoke(){
  }
}