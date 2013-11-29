class SoundTime {
  float time;
  String sound;
  
  public SoundTime(float inTime, String inSound) {
    time = inTime;
    sound = inSound;
  }
  
  public int compareTo(SoundTime other) {
    if (other.time > this.time) {
      return 1;
    } else if (other.time < this.time) {
      return -1;
    } else {
      return 0;
    }
  }
}
