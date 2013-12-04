class RecordButton extends floatingButton{
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
}
