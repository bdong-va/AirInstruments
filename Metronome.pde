class Metronome{
int BPM;
color c;
float x,y,w,h;
int counter;
float scale;
float beatNum;
String tickSound= "tick.wav";
String bigTickSound= "bigtick.wav";

  public Metronome(float x, float y, float w, float h, int beat, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.BPM = beat;
    this.counter = 1;
    beatNum = 4;
    scale = 0.0;
  }
  //calculate scale
  public float calcScale(float time) {
    int bar = (int)beatNum*(60000/BPM);
    float reminder = time % bar;
    return reminder/bar;
  }
  //rescale the position of Metronome's pointer.
  public void reScale(float time){
    float newScale = calcScale(time);
    // Logic for playing the metronome sound
    if (rec.isRecording) {
      if ( counter == 1 ) {
        audio = minim.loadFile(bigTickSound,512);
        audio.play();
        counter++;
      } else if ( counter == 2 && newScale > 1/beatNum * 1) {
        audio = minim.loadFile(tickSound,512);
        audio.play();
        counter++;
      } else if ( counter == 3 && newScale > 1/beatNum * 2) {
        audio = minim.loadFile(tickSound,512);
        audio.play();
        counter++;
      } else if ( counter == 4 && newScale > 1/beatNum * 3) {
        audio = minim.loadFile(tickSound,512);
        audio.play();
        counter++;
      }
    }
    // If the new scale is less than the old scale, reset the player index and beat counter
    if ( newScale < scale) {
      doLoop();
    }
    scale = newScale;
  }
  
  public void display(){
    //change the position of pointer.
    // Moved this line to the Player thread
    //this.reScale(millis());
    
    //draw the frame of Metronome
    float beatScale = 1/beatNum;
    noFill();
    rect(x,y,w,h,h/8,h/2,h/2,h/8);
    //draw the process bar
    for(int i = 0; i<beatNum; i++){
    noFill();
      if(scale > (i*beatScale) && scale < ((i+1)*beatScale)){
        fill(c);
      }
      rect(x,y,w*((i+1)*beatScale),h,h/8,h/2,h/2,h/8);
    }
    
    //draw the scale line.
    for(int i = 0; i<beatNum; i++){
    noFill();
      rect(x,y,w*((i+1)*beatScale),h,h/8,h/2,h/2,h/8);
    }
  }
  //can change the Beat per minute in this funtion.
  //beat is the beat per minute want the Metronome to do.
  public void setBPM(int beat){
  BPM = beat;
  }
  
  // Do loop logic
  public void doLoop() {
      // Reset the player pointer
      player.index = 0;
      // Set the beat counter back to 1
      counter = 1;
      // If we are recording, we should save the recording since we have looped
      if (rec.isRecording) {
        rec.saveRecording();
      }
  }
}
