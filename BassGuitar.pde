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
    if(chord<=500 && chord>200){
      audio = minim.loadFile(chord1,512);
    }else if(chord<=600 && chord>500){
      audio = minim.loadFile(chord2,512);
    }else if(chord<=700 && chord>600){
      audio = minim.loadFile(chord3,512);
    }else if(chord<=800 && chord>700){
      audio = minim.loadFile(chord4,512);
    }else if(chord<=900 && chord>800){
      audio = minim.loadFile(chord5,512);
    }
    // Play the chord
    audio.play();
 }
}
