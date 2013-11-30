class Metronome{
int BPM;
color c;
float x,y,w,h;
float counter;
float scale;
float beatNum;
  public Metronome(float x, float y, float w, float h, int beat, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.BPM = beat;
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
    // If the new scale is less than the old scale, reset the player index
    if ( newScale < scale) {
      player.index = 0;
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
  
}
