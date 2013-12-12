class BubbleChord{
float x,y;
String content;
color c;
float opacity;
float startTime;
  
  public BubbleChord(float x, float y, String content,color c){
    this.x = x;
    this.y = y;
    this.content = content.replace(".wav", "");
    this.c = c;
    this.opacity  = 100;
    startTime = 0;
  }
  public void display(){
    stroke(c,opacity);
    text(content, x, y);
    noFill();

  }
  public void bubble(){
    if(startTime == 0){
      startTime = millis();
    } else if(millis() - startTime > 50){
    this.y = this.y - 3; 
    this.opacity = this.opacity -1;
      if(opacity < 0){
        opacity = 100;
      }
    display();
    }
  }
  public boolean exploded(){
    if(opacity == 0){
      return true;
    }else
      return false;
    
  }
  
//  public void setContent(String s){
//    this.content = s;
//    display();
//  }
  
  
}
