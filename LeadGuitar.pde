class LeadGuitar implements Instrument{
  
  String chord1= "lead-A.wav";
  String chord2= "lead-Bm.wav";
  String chord3= "lead-D.wav";
  String chord4= "lead-F.wav";
  String chord5= "lead-G.wav";
 
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

