class User {

 // Attributes
 // userID
 // handID(s)?
 // Instrument
 
 // Methods
 // ----------------------------------------
 // Set the user's instrument
 void setInstrument(String instrument) {
   if (instrument == "bass") {
     this.instrument = new BassGuitar();
   } else if (instrument == "lead") {
     this.instrument = new LeadGuitar();
   }
 }
 
 // Play the user's instrument
 void playInstrument() {
     // Should get any necessary information (joint distances) here
 }
 
 // Get the user's handID(s)
 // Set the user's handID(s)
}
