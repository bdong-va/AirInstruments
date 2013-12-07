class PlayButton extends Button{
  //Recorder rec;
  public PlayButton(int x, int y, int d, String s, Recorder rec){
    super(x, y, d, s);
    //this.rec = rec;
  }
  
  public void invoke(){
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
    textAlign(CENTER);
    textSize(26);
    text(content, coordx,coordy+5);
  }
}
