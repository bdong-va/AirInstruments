class ClearButton extends Button{

  public ClearButton(int x, int y, int d, String s, Recorder rec){
    super(x, y, d, s);
    //this.rec = rec;
  }
  
  public void invoke(){
    if(rec.isRecordedSomething()){
      //reset the Recorder. 
      rec.stopPlaying();
      rec.stopRecording();
      rec.clearRecording();    
    }
  }
  
  public void display(){
    super.display();
    //display text about button.
    //TODO change thick and color of text
    textAlign(CENTER);
    textSize(26);
    content = (rec.isRecorded) ? "Clear" : " ";
    text(content, coordx,coordy+5);
  }
}
