class PlayButton extends floatingButton{
  //Recorder rec;
  public PlayButton(int x, int y, int d, String s, Recorder rec){
    super(x, y, d, s);
    //this.rec = rec;
  }
  
  public void invoke(){
    if(rec.isPlaying==true){
    rec.stopPlaying();
    content = "Play";
    }else{
    rec.startPlaying();
    content = "StopPlay";
    }
  }
}
