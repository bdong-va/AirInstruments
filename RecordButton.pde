class RecordButton extends Button{
  //Recorder rec;
  public RecordButton(int x, int y, int d, String s, Recorder rec){
    super(x, y, d, s);
    //this.rec = rec;
  }
  
  public void invoke(){
    super.invoke();
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
    
//    content = (rec.isRecording) ? "cancelRec" : "Record";
//    text(content, coordx,coordy+5);
    if (rec.isRecording) {
      // Draw cancel button
      float x1 = coordx - radius/2;
      float y1 = coordy - radius/2;
      float x2 = coordx - radius/2;
      float y2 = coordy + radius/2;
      float x3 = coordx + radius/2;
      float y3 = coordy - radius/2;
      float x4 = coordx + radius/2;
      float y4 = coordy + radius/2;
      
      // Draw an "X" on the button. 
      strokeWeight(5);
      stroke(0, 0, 0);
      line(x1,y1,x4,y4);
      line(x2,y2,x3,y3);
    } else {
      // Draw record button
      strokeWeight(5);
      stroke(0, 0, 0);
      fill(255, 0, 0);
      ellipse(coordx, coordy, radius, radius);
      
    }
    
  }
}
