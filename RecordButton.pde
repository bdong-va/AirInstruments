class RecordButton extends Button{
  //Recorder rec;
  public RecordButton(int x, int y, int d, String s, Recorder rec){
    super(x, y, d, s);
    //this.rec = rec;
  }
  
  public void invoke(){
    if(rec.isRecording==true){
      // If we are recording, stop recording and cancel it
      rec.stopRecording();
      rec.cancelRecording();
      content = "Record";
    }else{
      // If we arent recording, start recording and playing
      rec.startRecording();
      rec.startPlaying();
      content = "cancelRec";
    }
  }
  
  public void display(){
    super.display();
    //display text about button.
    //TODO change thick and color of text
    textAlign(CENTER);
    textSize(26);
    content = (rec.isRecording) ? "cancelRec" : "Record";
    text(content, coordx,coordy+5);
  }
}
