class PlayButton extends Button{
  //Recorder rec;
  public PlayButton(int x, int y, int d, String s, Recorder rec){
    super(x, y, d, s);
    //this.rec = rec;
  }
  
  public void invoke(){
    super.invoke();
    if(rec.isPlaying){
      // If we are already playing, but not recording, just stop
      // else, stop playing and recording and save the recording
      if (!rec.isRecording) {
        rec.stopPlaying();
      } else {
        rec.stopPlaying();
        rec.stopRecording();
        rec.saveRecording();
      }
      content = "Play";
    }else{
      // If we are not playing, just start playing
      rec.startPlaying();
      content = "StopPlay";
    }
  }
  
  public void display(){
    super.display();
    //display text about button.
    //TODO change thick and color of text
//    textAlign(CENTER);
//    textSize(26);
//    content = () ? "StopPlay" : "Play";
//    text(content, coordx,coordy+5);
    float x1 = coordx - radius/2;
    float y1 = coordy - radius/2;
    float x2 = coordx - radius/2;
    float y2 = coordy + radius/2;
    float x3 = coordx + radius/2;
    float y3 = coordy;
    stroke(0,0,0);
    if (rec.isPlaying){
      fill(255,0,0);
      rect(x1,y1, radius, radius);
    }else{  
      fill(0,255,0);   
      triangle(x1,y1,x2,y2,x3,y3);      
    }
    noFill();
  }
}
