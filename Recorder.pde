import java.util.*;

class Recorder {  
  
  /*
  * Variables
  */
  
  // State of recording/playing/quantizing
  boolean isRecording;
  boolean isPlaying;
  boolean isQuantizing;
  // Quantization factor
  // 1 means quantization to beats, 2 means to half beats, 4 to quarter, etc...
  int factor;
  
  // Data structure for storing notes/time
  ArrayList<SoundTime> soundTimes;
  
  // Depends upon BPM from Metronome
  
  /*
  * Constructor
  */
  public Recorder() {
    isRecording = false;
    isPlaying = false;
    isQuantizing = true;
    factor = 2;
    soundTimes = new ArrayList<SoundTime>();
  }
  
  /*
  * Methods
  */
  
  // Start recording
  public void startRecording() {
    isRecording = true;
  }
  
  // Stop recording
  public void stopRecording() {
    isRecording = false;
  }
  
  // Start playing
  public void startPlaying() {
    isPlaying = true;
  }
  
  // Stop playing
  public void stopPlaying() {
    isPlaying = false;
  }
  
  // Quantize Input
  public float quantizeInput(float inScale) {

    float beatScale = 1/(mn.beatNum*factor);
    
    for (int i = 0; i <= mn.beatNum*factor; i++) {
      if ( (inScale - i*beatScale ) < beatScale/2 ) {
        println(i*beatScale);
        return i*beatScale == 1 ? 0 : i*beatScale;
      }
    }
    return 200;
  }
  
  // Record Input
  public void recordInput(float inTime, String inSound) {
    // Scale the input time
    
    println("I am recording!");
    
    float thisScale = mn.calcScale(inTime);
    if (isQuantizing) {
      thisScale = quantizeInput(thisScale);
    }
    println(thisScale);
    // Create the soundTime
    SoundTime newSoundTime = new SoundTime(thisScale, inSound);
    // Add it to the list
    soundTimes.add(newSoundTime);
    // Sort the list
    Collections.sort(soundTimes);
  }
  
  // Play Sound
  public void playSound(String sound) {
    audio = minim.loadFile(sound,512);
    audio.play();
  }
  
}
