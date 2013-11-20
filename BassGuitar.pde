class BassGuitar implements Instrument{
  
  String chord1= "bass-1.wav";
  String chord2= "bass-2.wav";
  String chord3= "bass-3.wav";
  String chord4= "bass-4.wav";
  String chord5= "bass-5.wav";

  // Methods
  // ----------------------------------------
  // Play the guitar with supplied distance parameter
  void playGuitar(float chord){
    // Select the chord to play
     if(chord<=400 && chord>200){
      audio = minim.loadFile(chord1,512);
     }else if(chord<=550 && chord>400){
      audio = minim.loadFile(chord2,512);
     }else if(chord<=700 && chord>550){
      audio = minim.loadFile(chord3,512);
     }else if(chord<=850 && chord>700){
      audio = minim.loadFile(chord4,512);
     }else if(chord>850){
      audio = minim.loadFile(chord5,512);
     }
    // Play the chord
    audio.play();
 }
}
