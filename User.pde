class User {
  
 // Attributes
 // userID
 // handID(s)?
 Instrument instrum;
 
 // Methods
 // ----------------------------------------
 // Set the user's instrument
 void setInstrument(String instrument) {
   if (instrument == "bass") {
     this.instrum = new BassGuitar();
   } else if (instrument == "lead") {
     this.instrum = new LeadGuitar();
   }
 }
 
 // Play the user's instrument
 void playInstrument() {
     // Should get any necessary information (joint distances) here
 }
 
 // Get the user's handID(s)
 // Set the user's handID(s)
}
