class User {
  
 // Attributes
 int userID;
 int LHandID, RHandID;
 Instrument instrument;
 boolean prevPos, curPos; // For detecting crossing guitar string
 int lastPlayed;
 
 // Constructor
 User (int ID) {
   userID = ID;
   LHandID = 0;
   RHandID = 0;
   instrument = new LeadGuitar();
   prevPos = false;
   curPos = false;   
   lastPlayed = 0;
 }
 
 // Methods
 // ----------------------------------------
 
 // Set the user's instrument
 void setInstrument(String instrument) {
   if (instrument.equals("bass")) {
     this.instrument = new BassGuitar();
   } else if (instrument.equals("lead")) {
     this.instrument = new LeadGuitar();
   }
 }
 
 // Get the users instrument (? Do we need it? )
 String getInstrument() {
   if (instrument instanceof LeadGuitar) {
     return "lead";
   } else if (instrument instanceof BassGuitar) {
     return "bass";
   } else {
<<<<<<< HEAD
     return "none";
=======
      return null;   
>>>>>>> refs/heads/buttonWork2
   }
 }
 
 // Play the user's instrument
 void playInstrument() {
     // Should get any necessary information (joint distances) here
 }
 
 // Hand ID getters/setters
 int getLHandID() { return LHandID; }
 int getRHandID() { return RHandID; }
 void setLHandID(int ID) { LHandID = ID; }
 void setRHandID(int ID) { RHandID = ID; }
 
}
