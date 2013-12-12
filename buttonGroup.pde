class buttonGroup{
  int userID;
  Button[] currentButtons;
  Button[] buttons;
  ArrayList<BubbleChord> bubbles;
  
  int groupHeight =50;
  int ButtonRadius = 40;
  
  public buttonGroup(){
    userID = 0;
    currentButtons = new Button[4];
    buttons  = new Button[5];
    bubbles = new ArrayList<BubbleChord>();
    groupHeight = 50;
    ButtonRadius = 40;
    //set empty buttons, prevent null pointer.(I hate null pointer!)
    for(int i = 0; i<buttons.length; i++){
      buttons[i] = new Button(0,0,ButtonRadius, "Test");   
    }
    for(int i = 0; i<currentButtons.length;i++){
      this.setCurrentButton(i,i);
    }
  }
  
  //put a Button into buttons array.
  public void setButton(int order, Button fb){
    if (order>buttons.length){
      //TODO add throw/catch
      println("setButton in buttonGroup does not works well.");
    } else {
      buttons[order] = fb;
      fb.setButtonGroup(this);
    }
  }
  
  //set one button in buttons array into Current button.
  public void setCurrentButton(int orderB, int orderC){
    if (orderB>buttons.length || orderC>currentButtons.length){
      //TODO add throw/catch
      println("setCurrentButton in buttonGroup does not works well.");
    }else{
      currentButtons[orderC] = buttons[orderB];    
    }
  }
  //insert new bubbleChord into list
  public void insertBubble(float x, float y, String s,color c){
  BubbleChord bc = new BubbleChord(x,y,s,c);
  bubbles.add(bc);

  checkExplode();
  }
  
  public void drawCurrentButton(float x, float y){
     for(int i = 0; i<currentButtons.length;i++){
       //println("i="+i+"; x="+x+"; y="+y+". ");
        currentButtons[i].setPosition((int)(x+2*ButtonRadius*i),(int)(y-groupHeight+(groupHeight*i)/2));
        currentButtons[i].display();
     }
     bubble();
  }
  
  public void checkCurrentButton(int x, int y){
    for(int i = 0; i<currentButtons.length;i++){
      currentButtons[i].isTouched(x, y);
    }
  }
  //set user which this group belong to.
  public void setUser(int u){
    userID = u;
  }
  
  public void bubble(){
    for(int i = 0; i<bubbles.size(); i++){
      BubbleChord bc = bubbles.get(i);
      bc.bubble();
      bc.display();
    }
    checkExplode();
  }
  
  public void checkExplode(){
     for(int i = 0; i<bubbles.size(); i++){
      BubbleChord bc = bubbles.get(i);
      if(bc.exploded()== true){
        bubbles.remove(i);
      }
      bc.display();
    }
  }
}
