import ddf.minim.*;

AudioPlayer audio;
Minim minim;


void setup()
{
  size(800,600);
  noFill();
  minim = new Minim(this);

  stroke(0);
  strokeWeight(1);
  rect(100,100,100,50);
}
void draw()
{
  background(0);
  stroke(255);
}

void keyPressed(){
  if(key =='1'){
    audio = minim.loadFile("guitarAm.wav",512);
    audio.play();
  }else if(key =='2'){
    audio = minim.loadFile("guitarC.wav",512);
    audio.play();
  }else if(key =='3'){
    audio = minim.loadFile("guitarDm.wav",512);
    audio.play();
  }else if(key =='4'){
    audio = minim.loadFile("guitarE.wav",512);
    audio.play();
  }else if(key =='5'){
    audio = minim.loadFile("guitarG.wav",512);
    audio.play();
  }
}
