class BassGuitar {
  // Methods
  // ----------------------------------------
  // Play the guitar with supplied distance parameter
  void playBassGuitar(float chord){
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
