class RecordButton extends floatingButton{
  //Recorder rec;
  public RecordButton(int x, int y, int d, String s, Recorder rec){
    super(x, y, d, s);
    //this.rec = rec;
  }
  
  public void invoke(){
    if(rec.isRecording==true){
      rec.stopRecording();
      content = "Record";
    }else{
      rec.startRecording();
      content = "StopRec";
    }
  }
}
