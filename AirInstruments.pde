/* --------------------------------------------------------------------------
 * AirInstruments
 * --------------------------------------------------------------------------
 * Authors: Jason Prokop and Bo Dong
 * ----------------------------------------------------------------------------
 */
 
import ddf.minim.*;
import SimpleOpenNI.*;

SimpleOpenNI  kinect;
User[]        users = new User[4];
color[]       userClr = new color[]{ color(255,0,0),
                                     color(0,255,0),
                                     color(0,0,255),
                                     color(255,255,0),
                                     color(255,0,255),
                                     color(0,255,255)
                                   };
instrumentChoose[]  button = new instrumentChoose[4];
String[] InstrumentList = {"lead","bass"};
AudioPlayer audio;
Minim minim;

// Setup
void setup()
{
  // Create and initialize the kinect
  kinect = new SimpleOpenNI(this);
  noFill();
  if(kinect.isInit() == false)
  {
     println("Kinect was not initalized! Exiting.."); 
     exit();
     return;  
  }
  //set button group for users.
  for(int i=0;i<4;i++){
    button[i]= new instrumentChoose(0,0,80,InstrumentList);
  }
  // Create Minim object
  minim = new Minim(this);
  
  // enable depthMap and RGB generation from Kinect
  kinect.enableDepth();
  kinect.enableRGB();
   
  // enable skeleton generation for all joints
  kinect.enableUser();
  
  // Set mirror false for projecting camera view to an audience
  kinect.setMirror(true);
  // Set the mirror on for practicing (add this functionality?)
  // Detect a more complex gesture for mirroring the video?
  
  // Enable hand tracking and start the wave gesture
  kinect.enableHand();
  kinect.startGesture(SimpleOpenNI.GESTURE_WAVE);
  
  // Inherit the size of the RGB image
  //size(kinect.rgbWidth(), kinect.rgbHeight());
  size(640,480);
  
  // Prepare graphics
  background(200,0,0);
  stroke(0,0,255);
  strokeWeight(3);
  smooth();  
}

// Draw
void draw()
{
  // Update the Kinect data
  kinect.update();
  
  // Draw the screens
  //image(kinect.depthImage(),0,0);
  //image(kinect.userImage(),0,0);
  image(kinect.rgbImage(), 0, 0);
  
  // Get the user id list and perform updates for each that are tracked
  int[] userList = kinect.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(kinect.isTrackingSkeleton(userList[i]))
    {
      // Draw the skeleton, dev only
      stroke(userClr[ 5 ] );
      //drawSkeleton(userList[i]); 
      
      //draw a sign for a tracked hand.
      PVector handPos = users[userList[i]].handPos;
      if (handPos != null) {
        strokeWeight(3);
        kinect.convertRealWorldToProjective(handPos,handPos);
        ellipse(handPos.x, handPos.y, 10, 10);
      }
  
      // Draw guitar
      PVector LHand = users[userList[i]].LHand;
      PVector Hip = users[userList[i]].Hip;
      kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_LEFT_HAND, LHand);
      kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_RIGHT_HIP, Hip);
      float chord = Hip.dist(LHand);
      
      // Draw button for each user
      PVector Head = users[userList[i]].Head;
      PVector Head2D = users[userList[i]].Head2D;
      kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_HEAD, Head);
      kinect.convertRealWorldToProjective(Head,Head2D);
      button[i].setPosition((int)Head2D.x, (int)Head2D.y-50); 
      button[i].display();
      button[i].setUser(userList[i]);      
      
      
      //check button for if been clicked.
      PVector RHand = users[userList[i]].RHand;
      PVector RHand2D = users[userList[i]].RHand2D;
      kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_RIGHT_HAND, RHand);
      kinect.convertRealWorldToProjective(users[userList[i]].RHand, RHand2D);

      button[i].isTouched((int)RHand2D.x,(int)RHand2D.y);      
      
      
      // Adjust the weight of the string depending on its length
      if(chord<=400 && chord>200){
        strokeWeight(2);
      }else if(chord<=550 && chord>400){
        strokeWeight(4);
      }else if(chord<=700 && chord>550){
        strokeWeight(6);
      }else if(chord<=850 && chord>700){
        strokeWeight(8);
      }else if(chord>850){
        strokeWeight(10);
      }
      // Make the string green if it was recently played; black if not
      if ( (millis() - users[userList[i]].lastPlayed) < 200 ) {
        stroke(0, 255, 0);
      } else {
        stroke(0, 0, 0);
      }
      kinect.drawLimb(userList[i], SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HAND);
    }      
  }    
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{  
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  // Create a user with that userID
  users[userId] = new User(userId);
  
  // Print to screen to inform user
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  // Start tracking the skeleton
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  // println("onLostUser - userId: " + userId);
  // Print to screen to inform user
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
  // Draw the menu above their head ??
}

// -----------------------------------------------------------------
// hand events

void onNewHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  println("onNewHand - handId: " + handId + ", pos: " + pos);
  // Determine the userId of this hand. - = left, + = right hands
  int bestUserID = determineHand(pos);
  println("HandID " + handId + " matched to UserID " + bestUserID);
  if (bestUserID == 0) {
    // Handle this case somehow
  } else {
    // Assign that handId to the User's correct hand
    if (bestUserID < 0) {
      users[abs(bestUserID)].setLHandID(handId);
    } else {
      users[abs(bestUserID)].setRHandID(handId);
    }
  }
}

void onTrackedHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  // Get the user ID for this hand
  int userID = getUserFromHandID(handId);
  
  if (userID == 0) {
    // Handle no user case
    // Try to find user again?
  } else {
    users[userID].handPos = pos;
    // Check time last played to see if we should bother trying to let them play
    // If it has been under 100 ms since the last play, just return
    if ( (millis() - users[userID].lastPlayed) < 200 ) {
      return;
    }
    // Do update for that user... different for different instruments/states
    if ( users[userID].getInstrument().equals("none") ) {
      // Do menus / instrument selection
    } else if (users[userID].getInstrument().equals("lead") || users[userID].getInstrument().equals("bass")) {
      // Try to play the guitar
      
      // Create the vectors and fill them with data from kinect
      PVector LHand = new PVector();
      PVector RHand = new PVector();
      PVector Hip = new PVector();
      // We want to use the hand vector for the  dominant hand of that user
      // And the corresponding hop
      if (handId == users[userID].getLHandID()) {
        // It's their left hand. Use hand vector for it
        LHand = pos;
        kinect.getJointPositionSkeleton(userID, kinect.SKEL_RIGHT_HAND, RHand);
        kinect.getJointPositionSkeleton(userID, kinect.SKEL_LEFT_HIP, Hip);
      } else {
        kinect.getJointPositionSkeleton(userID, kinect.SKEL_LEFT_HAND, LHand);
        RHand = pos;
        kinect.getJointPositionSkeleton(userID, kinect.SKEL_RIGHT_HIP, Hip);
      }
      
      // See what side of the string the hand is on
      users[userID].curPos = isOnTopOfLine(LHand.x, LHand.y, Hip.x, Hip.y, RHand.x, RHand.y);
      
      // If the hand cross the string...
      if (users[userID].curPos != users[userID].prevPos){
        // Calculate chord distance
        println("played");
        float chordPos = Hip.dist(LHand);
        // Dev printing -- should probably indicate to user visually too
        // println("distance:"+chordPos);
        // Play the guitar
        users[userID].instrument.playGuitar(chordPos);
        // Save this
        users[userID].prevPos = users[userID].curPos;
        // Record this as the time last played
        users[userID].lastPlayed = millis();
      }
    } else {
      // Other instruments?
    }
  }
}

int getUserFromHandID(int handId) {
  // Get the user ID with this hand
  int[] ul = kinect.getUsers();
  for(int i=0;i<ul.length;i++) {
    if(kinect.isTrackingSkeleton(ul[i]))
    {
      if ( handId == users[ul[i]].getLHandID() || handId == users[ul[i]].getRHandID() ) {
        return users[ul[i]].userID;
      }
    }
  }
  println("no match"); 
  return 0; // No match found
}
  
void onLostHand(SimpleOpenNI curContext,int handId)
{
  int userID = getUserFromHandID(handId);
  users[userID].handPos = null;
}

// -----------------------------------------------------------------
// gesture events

void onCompletedGesture(SimpleOpenNI curContext,int gestureType, PVector pos)
{
  // Dev printing
  // println("onCompletedGesture - gestureType: " + gestureType + ", pos: " + pos);
  
  int handId = curContext.startTrackingHand(pos);
  // Returns 0 if we're already tracking the hand, I think...
  // println("hand tracked: " + handId);
}

// Detect if a point is on top of a line defined by two other points
// Return true if it is above or on, false if not
boolean isOnTopOfLine(float x1,float y1,float x2, float y2, float xp, float yp){
  float xl;
  xl = (((x1-x2)*(yp-y2))/(y1-y2))+x2;
  return (xp >= xl);
}

// Determine what userID the hand belongs to  
int determineHand(PVector handPos) {
  // Initialize solution parameters
  float minDist = 1500;
  int bestUser = 0;
  
  // For each user, if we're tracking them, compare their hands to the hand position
  // Keep track of which user has the best match
  int[] userList = kinect.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(kinect.isTrackingSkeleton(userList[i]))
    {
      // Create the vectors and calculate the distances of each hand
      PVector LHand = new PVector();
      PVector RHand = new PVector();
      kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_LEFT_HAND, LHand);
      kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_RIGHT_HAND, RHand);
      float LDist = handPos.dist(LHand);
      float RDist = handPos.dist(RHand); 
       if (LDist < minDist) 
       {
         // Negative userID implies left
         bestUser = -userList[i];
         minDist = LDist;
       }
       if (RDist < minDist)
       {
         bestUser = +userList[i];
         minDist = RDist;
       }
    }
  }
  if ( bestUser == 0 ) {
    println("Could not match hand to a user");
    return 0;
  } else {
    // Dev printing
    // println("Hand " + handId + " belonds to user " + bestUser);
    return bestUser;
  }
}
