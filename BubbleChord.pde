class BubbleChord{
float x,y;
String content;
color c;
float opacity;
float startTime;
  
  public BubbleChord(float x, float y, String content,color c){
    this.x = x;
    this.y = y;
    this.content = content;
    this.c = c;
    this.opacity  = 0;
    startTime = 0;
  }
  public void display(){
    fill(c,opacity);
    text(content, x, y);
  }
  public void bubble(){
    if(startTime == 0){
      startTime = millis();
    }
    if(startTime - millis() > 50){
    this.y = this.y - 1; 
    this.opacity = this.opacity +3;
      if(opacity > 100){
        opacity = 100;
      }
    display();
    }
  }
  public boolean exploded(){
    if(opacity == 100){
      return true;
    }else
      return false;
    
  }
  
  public void setContent(String s){
    this.content = s;
    display();
  }
  
  
}
