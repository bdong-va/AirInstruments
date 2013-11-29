class SoundTime implements Comparable<SoundTime> {
  float time;
  String sound;
  
  public SoundTime(float inTime, String inSound) {
    time = inTime;
    sound = inSound;
  }
  
  public int compareTo(SoundTime other) {
    return (int)(this.time - other.time);
  }
}
