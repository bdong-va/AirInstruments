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
      // Update the metronome
      mn.reScale(millis());
      // While we are playing, there are notes, and we're not done playing them all....
      if (rec.isPlaying && rec.soundTimes.size() != 0 && index < rec.soundTimes.size()  ) {
        // Read the time and sound of the current note
        float time = rec.soundTimes.get(index).time;
        String sound = rec.soundTimes.get(index).sound;
        // Read the metrononome time
        float mTime = mn.scale;
        // If we have passed the note, play it and then move on
        if ( time < mTime ) {
          playSound(sound);
          index++;
        }
      }
      // Wait 
      try {
        sleep((long)wait);
      } catch (Exception e) {}
    }    
  }
  
  void quit() {
    System.out.println("Quitting."); 
    rec.isPlaying = false;  // Setting running to false ends the loop in run()
    // In case the thread is waiting. . .
    interrupt();
  }
  
  // Play Sound
  public void playSound(String sound) {
    audio = minim.loadFile(sound,512);
    audio.play();
  }
 
 
  
}
