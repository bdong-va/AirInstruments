class User {
  
 // Attributes
 int userID;
 int LHandID, RHandID;
 PVector handPos;
 PVector LHand, RHand,Hip,Head;
 PVector LHand2D, RHand2D, Hip2D, Head2D;
 Instrument instrument;
 buttonGroup btngrp;
 boolean prevPos, curPos; // For detecting crossing guitar string
 int lastPlayed;
 
 // Constructor
 User (int ID) {
   userID = ID;
   LHandID = 0;
   RHandID = 0;
   handPos = null;
   instrument = new LeadGuitar();
   prevPos = false;
   curPos = false;   
   lastPlayed = 0;
   LHand = new PVector();
   RHand = new PVector();
   Hip = new PVector();
   Head = new PVector();
   LHand2D = new PVector();
   RHand2D = new PVector();
   Hip2D = new PVector();
   Head2D = new PVector();  
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

     return "none";
   }
 }
 
 // Play the user's instrument
 void playInstrument() {
     // Should get any necessary information (joint distances) here
 }
 //set Button Group to a user
 void setButtonGroup(buttonGroup bg){
 btngrp = bg;
 }
 
 // Hand ID getters/setters
 int getLHandID() { return LHandID; }
 int getRHandID() { return RHandID; }
 void setLHandID(int ID) { LHandID = ID; }
 void setRHandID(int ID) { RHandID = ID; }
 
}
