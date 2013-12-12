class instrumentChoose extends Button {
  int instrumentNumber = 2;
  int currentInstrument = 0;
  String[] instrumentList = new String[instrumentNumber];
  
  public instrumentChoose(int x, int y, int d, String s[]){
    super(x, y, d, s[0]);
    for(int i = 0; i<instrumentNumber; i++){
      instrumentList[i] = s[i];
    }
  }
  
  public void invoke(){
    super.invoke();
    if(currentInstrument<instrumentNumber-1){
      currentInstrument++;
    }else{
      currentInstrument = 0;
    }
    content = instrumentList[currentInstrument];
    println(content);
    users[getButtonGroup().userID].setInstrument(content);
  }
  public void display(){
    super.display();
    //display text about button.
    //TODO change thick and color of text
    textAlign(CENTER);
    textSize(26);
    stroke(0,0,0);
    text(content, coordx,coordy+5);
  }
}
