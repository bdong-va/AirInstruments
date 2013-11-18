class User {
  
 // Attributes
 int UserID;
 int LHandID, RHandID;
 Instrument instrument;
 
 // Methods
 // ----------------------------------------
 
 // Set the user's instrument
 void setInstrument(String instrument) {
   if (instrument.equals("bass")) {
     this.instrum = new BassGuitar();
   } else if (instrument.equals("lead")) {
     this.instrum = new LeadGuitar();
   }
 }
 
 // Get the users instrument (? Do we need it? )
 String getInstrument() {
   if (instrument instanceof LeadGuitar) {
     return "lead";
   } elseif (instrument instanceof bassGuitar) {
     return "bass";
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
