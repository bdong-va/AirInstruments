class Recorder {  
  
  /*
  * Variables
  */
  
  // State of recording/playing
  boolean isRecording;
  boolean isPlaying;
  
  // Data structure for storing notes/time
  ArrayList<SoundTime> soundTimes;
  
  // Depends upon BPM from Metronome
  
  /*
  * Constructor
  */
  public Recorder() {
    isRecording = false;
    isPlaying = false;
    soundTimes = new ArrayList<SoundTime>();
  }
  
  /*
  * Methods
  */
  
  // Start recording
  public void startRecording() {}
  
  // Stop recording
  public void stopRecording() {}
  
  // Start playing
  public void startPlaying() {}
  
  // Stop playing
  public void stopPlaying() {}
  
  // Quantize Input
  public float quantizeInput(float inTime) {
    return null;
  }
  
  // Record Input
  public void recordInput(float inTime, String inSound) {}
  
  // Play Sound
  public void playSound(String sound) {}
  
}
