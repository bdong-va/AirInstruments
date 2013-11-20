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

