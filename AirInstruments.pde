/* --------------------------------------------------------------------------
 * AirInstruments
 * --------------------------------------------------------------------------
 * Authors: Jason Prokop and Bo Dong
 * ----------------------------------------------------------------------------
 */
 
import ddf.minim.*;
import SimpleOpenNI.*;

SimpleOpenNI  kinect;
User[]        users;
color[]       userClr = new color[]{ color(255,0,0),
                                     color(0,255,0),
                                     color(0,0,255),
                                     color(255,255,0),
                                     color(255,0,255),
                                     color(0,255,255)
                                   };

// Example variable for center of mass -- cleanup
//PVector com = new PVector();                                   
//PVector com2d = new PVector(); 
// Player variables, moved to User
//PVector leftHandPos = new PVector();
//PVector rightHandPos = new PVector();
//PVector hipPos = new PVector();

//boolean prevPos = false;
//float chordPos;
// Guitar sounds, moved to guitar classes
//String chord1= "guitarAm.wav";
//String chord2= "guitarC.wav";
//String chord3= "guitarDm.wav";
//String chord4= "guitarE.wav";
//String chord5= "guitarG.wav";
AudioPlayer audio;
Minim minim;

// Setup
void setup()
{
  // Create and initialize the kinect
  kinect = new SimpleOpenNI(this);
  if(kinect.isInit() == false)
  {
     println("Kinect was not initalized! Exiting.."); 
     exit();
     return;  
  }
  
  // Create Minim object
  minim = new Minim(this);
  
  // enable depthMap and RGB generation from Kinect
  kinect.enableDepth();
  
   
  // enable skeleton generation for all joints
  kinect.enableUser();
  
  // Set mirror false for projecting camera view to an audience
  kinect.setMirror(false);
  // Set the mirror on for practicing (add this functionality?)
  // Detect a more complex gesture for mirroring the video?
  
  // Enable hand tracking and start the hand raise gesture
  kinect.enableHand();
  kinect.startGesture(SimpleOpenNI.GESTURE_HAND_RAISE);
  
  // Inherit the size of the RGB image
  size(kinect.rgbWidth(), kinect.rgbHeight());
  //size(640,480);
  
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
      // stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      // drawSkeleton(userList[i]);
      
      
     /* Old code, moved to hand events
     kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_LEFT_HAND, leftHandPos);
     kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_RIGHT_HAND, rightHandPos);
     kinect.getJointPositionSkeleton(userList[i], kinect.SKEL_RIGHT_HIP, hipPos);
     boolean currentPos;
     currentPos = isOnTopOfLine(leftHandPos.x,leftHandPos.y,hipPos.x,hipPos.y,rightHandPos.x,rightHandPos.y );
     chordPos = hipPos.dist(leftHandPos);
     if(currentPos != prevPos){
       println("distance: "+chordPos+"   userHeight: "+kinect.userHeight());
       playGuitar(chordPos);
       prevPos = currentPos;
     }
     */
     
      
    }      
      
    /* Old example code for drawing user's CoM
    if(kinect.getCoM(userList[i],com))
    {
      kinect.convertRealWorldToProjective(com,com2d);
      stroke(100,255,0);
      strokeWeight(1);
      beginShape(LINES);
        vertex(com2d.x,com2d.y - 5);
        vertex(com2d.x,com2d.y + 5);

        vertex(com2d.x - 5,com2d.y);
        vertex(com2d.x + 5,com2d.y);
      endShape();
      
      fill(0,255,100);
      text(Integer.toString(userList[i]),com2d.x,com2d.y);
    }
    */
  }    
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  println(jointPos);
  */
  
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
  //println("\tstart tracking skeleton");
  
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
  // println("onVisibleUser - userId: " + userId);
  // Draw the menu above their head ??
}

// -----------------------------------------------------------------
// hand events

void onNewHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  println("onNewHand - handId: " + handId + ", pos: " + pos);
  // Determine the userId of this hand. - = left, + = right hands
  int bestUserID = determineHand(pos);
  if (bestUserID == -1) {
    // Handle this case somehow
  } else {
    // Assign that handId to the User's correct hand
    users[abs(bestUserID)].userID = abs(bestUserID);
    if (bestUserID < 0) {
      users[abs(bestUserID)].LHandID = handId;
    } else {
      users[abs(bestUserID)].RHandID = handId;
    }
  }
}

void onTrackedHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  // Do we ignore same position updates?
  /* if (lastPos == pos) {
      return;
     }else {
       lastPos = pos;
     }
   */
     
  int userID = getUserFromHandID(handId);
  if (userID == -1) {
    // Handle no user case
    // Try to find user again?
  } else {
    // Do update for that user... different for different instruments/states
    if ( users[userID].instrument == null ) {
      // Do menus / instrument selection
    } else if (users[userID].instrument.equals("lead") || users[userID].instrument.equals("bass")) {
      // Try to play the guitar
      
      // Create the vectors and fill them with data from kinect
      PVector LHand = new PVector();
      PVector RHand = new PVector();
      PVector RHip = new PVector();
      kinect.getJointPositionSkeleton(userID, kinect.SKEL_LEFT_HAND, LHand);
      kinect.getJointPositionSkeleton(userID, kinect.SKEL_RIGHT_HAND, RHand);
      kinect.getJointPositionSkeleton(userID, kinect.SKEL_RIGHT_HIP, RHip);
      
      // See what side of the string the hand is on
      users[userID].curPos = isOnTopOfLine(LHand.x, LHand.y, RHip.x, RHip.y, RHand.x, RHand.y);
      
      // If the hand cross the string...
      if (users[userID].curPos != users[userID].prevPos){
        // Calculate chord distance
        float chordPos = RHip.dist(LHand);
        // Dev printing -- should probably indicate to user visually too
        // println("distance:"+chordPos);
        // Play the guitar
        users[userID].instrument.playGuitar(chordPos);
        // Save this
        users[userID].prevPos = users[userID].curPos;
      }
    } else {
      // Other instruments?
    }
  }
}

int getUserFromHandID(int handId) {
  // Get the user ID with this hand
  int[] userList = kinect.getUsers();
  for(int i=0;i<userList.length;i++) {
    if ( users[i] != null ) {
      if ( handId == users[i].getLHandID() || handId == users[i].getRHandID() ) {
        return users[i].userID;
      }
    }
  }
  return -1; // No match found
}
  
void onLostHand(SimpleOpenNI curContext,int handId)
{
  println("onLostHand - handId: " + handId);
}

// -----------------------------------------------------------------
// gesture events

void onCompletedGesture(SimpleOpenNI curContext,int gestureType, PVector pos)
{
  println("onCompletedGesture - gestureType: " + gestureType + ", pos: " + pos);
  
  int handId = curContext.startTrackingHand(pos);
  println("hand tracked: " + handId);
}

// Detect if a point is on top of a line defined by two other points
// Return true if it is above or on, false if not
boolean isOnTopOfLine(float x1,float y1,float x2, float y2, float xp, float yp){
  float xl;
  xl = (((x1-x2)*(yp-y2))/(y1-y2))+x2;
  return (xp >= xl);
}

/* Old code, moved to guitar classes
// Play the guitar with supplied distance paramter
void playGuitar(float chord){
  if(chord<=500 && chord>200){
    audio = minim.loadFile(chord1,512);
        audio.play();
  }else if(chord<=600 && chord>500){
    audio = minim.loadFile(chord2,512);
        audio.play();
  }else if(chord<=700 && chord>600){
    audio = minim.loadFile(chord3,512);
        audio.play(); 
  }else if(chord<=800 && chord>700){
    audio = minim.loadFile(chord4,512);
        audio.play();
  }else if(chord<=900 && chord>800){
    audio = minim.loadFile(chord5,512);
        audio.play();
  }
}
*/

// Determine what userID the hand belongs to  
int determineHand(PVector handPos) {
  // Initialize solution parameters
  float minDist = 1500;
  int bestUser = -1;
  
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
         bestUser = -i;
         minDist = LDist;
       }
       if (RDist < minDist)
       {
         bestUser = +i;
         minDist = RDist;
       }
    }
  }
  if ( bestUser == -1 ) {
    println("Could not match hand to a user");
    return -1;
  } else {
    // Dev printing
    // println("Hand " + handId + " belonds to user " + bestUser);
    return bestUser;
  }
}
