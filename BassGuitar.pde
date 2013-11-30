class BassGuitar implements Instrument{
  
  String chord1= "bass-1.wav";
  String chord2= "bass-2.wav";
  String chord3= "bass-3.wav";
  String chord4= "bass-4.wav";
  String chord5= "bass-5.wav";
  String sound;
  // Methods
  // ----------------------------------------
  // Play the guitar with supplied distance parameter
  void playGuitar(float chord){
    // Select the chord to play

     if(chord<=400 && chord>200){
      sound = chord1;
     }else if(chord<=550 && chord>400){
      sound = chord2;
     }else if(chord<=700 && chord>550){
      sound = chord3;
     }else if(chord<=850 && chord>700){
      sound = chord4;
     }else if(chord>850){
      sound = chord5;
     }
    // Play the chord
    audio = minim.loadFile(sound,512);
    audio.play();
    
    if(rec.isRecording==true){
      rec.recordInput(millis(), sound);
    }
 }
 
 String getSound(){
  return sound;
 }
}
