class Player extends Thread {
  int wait;
  int index;
  
  Player (int inWait) {
      wait = inWait;
      index = 0;
      super.start();
  }
    
  void run() {
    while (true) {
      // While we are playing and there are notes to play
      if (rec.isPlaying && rec.soundTimes.size() != 0 ) {
        // Read the time and sound of the current note
        float time = rec.soundTimes.get(index).time;
        String sound = rec.soundTimes.get(index).sound;
        // Read the metrononome time
        float mTime = mn.scale;
        // If we have passed the note, play it and then move on
        if ( time > mTime ) {
          playSound(sound);
          index++;
          // If we've passed the bounds of the array, go back to the start
          if (index >= rec.soundTimes.size()) {
            index = 0;
          }
        }
      }
      // Wait 
      try {
        sleep((long)wait);
      } catch (Exception e) {}
    }    
  }
  
  // Play Sound
  public void playSound(String sound) {
    audio = minim.loadFile(sound,512);
    audio.play();
  }
 
  
}
