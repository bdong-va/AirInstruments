/* --------------------------------------------------------------------------
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */
import ddf.minim.*;
import SimpleOpenNI.*;

SimpleOpenNI  context;
color[]       userClr = new color[]{ color(255,0,0),
                                     color(0,255,0),
                                     color(0,0,255),
                                     color(255,255,0),
                                     color(255,0,255),
                                     color(0,255,255)
                                   };
PVector com = new PVector();                                   
PVector com2d = new PVector();                                   
PVector leftHandPos = new PVector();
PVector rightHandPos = new PVector();
PVector hipPos = new PVector();
boolean prevPos = false;
float chordPos;
String chord1= "guitarAm.wav";
String chord2= "guitarC.wav";
String chord3= "guitarDm.wav";
String chord4= "guitarE.wav";
String chord5= "guitarG.wav";
AudioPlayer audio;
Minim minim;
void setup()
{
  size(640,480);
  
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  minim = new Minim(this);
  
  // enable depthMap generation 
  context.enableDepth();
   
  // enable skeleton generation for all joints
  context.enableUser();
  
  // Enable hand tracking and start a gesture
  context.enableHand();
  context.startGesture(SimpleOpenNI.GESTURE_WAVE);
 
  background(200,0,0);

  stroke(0,0,255);
  strokeWeight(3);
  smooth();  
}

void draw()
{
  // update the cam
  context.update();
  
  // draw depthImageMap
  //image(context.depthImage(),0,0);
  image(context.userImage(),0,0);
  
  // draw the skeleton if it's available
  int[] userList = context.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(context.isTrackingSkeleton(userList[i]))
    {
      stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      drawSkeleton(userList[i]);
      
      
     context.getJointPositionSkeleton(userList[i], context.SKEL_LEFT_HAND, leftHandPos);
     context.getJointPositionSkeleton(userList[i], context.SKEL_RIGHT_HAND, rightHandPos);
     context.getJointPositionSkeleton(userList[i], context.SKEL_RIGHT_HIP, hipPos);
     boolean currentPos;
     currentPos = isOnTopOfLine(leftHandPos.x,leftHandPos.y,hipPos.x,hipPos.y,rightHandPos.x,rightHandPos.y );
     chordPos = hipPos.dist(leftHandPos);
     if(currentPos != prevPos){
       println("distance:"+chordPos);
       playGuitar();
       prevPos = currentPos;
     }
     
      
    }      
      
    // draw the center of mass
    if(context.getCoM(userList[i],com))
    {
      context.convertRealWorldToProjective(com,com2d);
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
  }    
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  println(jointPos);
  */
  
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  // Print to screen to inform user
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
  // Print to screen to inform user
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  println("onVisibleUser - userId: " + userId);
  // Draw the menu above their head ??
}

// -----------------------------------------------------------------
// hand events

void onNewHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  println("onNewHand - handId: " + handId + ", pos: " + pos);
  // Figure out who's hand it is
  float minDist = 500;
  int bestUser = -1;
  int[] userList = context.getUsers();
  // For each user, if we're tracking them, compare their hands to this point
  // Keep track of which user has the best match
  for(int i=0;i<userList.length;i++)
  {
    if(context.isTrackingSkeleton(userList[i]))
    {
      PVector LHand = new PVector();
      PVector RHand = new PVector();
      context.getJointPositionSkeleton(userList[i], context.SKEL_LEFT_HAND, LHand);
      context.getJointPositionSkeleton(userList[i], context.SKEL_RIGHT_HAND, RHand);
      float LDist = pos.dist(LHand);
      float RDist = pos.dist(RHand); 
     if (LDist < minDist) 
     {
       bestUser = i;
       minDist = LDist;
     }
     if (RDist < minDist)
     {
       bestUser = i;
       minDist = RDist;
     }
    }
  }
  if ( bestUser = -1 ) {
    println("Could not match hand to a user");
  } else {
    println("Hand " + handId + " belonds to user " + bestUser);
    // TODO: Record that in some data structure...
  }
}

void onTrackedHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  // TODO: Get the userId that this hand belongs to, rewrite to do detection for that user's info
  boolean currentPos;
     currentPos = isOnTopOfLine(leftHandPos.x,leftHandPos.y,hipPos.x,hipPos.y,rightHandPos.x,rightHandPos.y );
     chordPos = hipPos.dist(leftHandPos);
     if(currentPos != prevPos){
       println("distance:"+chordPos);
       playGuitar();
       prevPos = currentPos;
     }
  
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
  
  int handId = context.startTrackingHand(pos);
  println("hand stracked: " + handId);
}

boolean isOnTopOfLine(float x1,float y1,float x2, float y2, float xp, float yp){
  float xl;
  xl = (((x1-x2)*(yp-y2))/(y1-y2))+x2;
  return (xp >= xl);

}
void playGuitar(){
  
  if(chordPos<=500 && chordPos>200){
    audio = minim.loadFile(chord1,512);
        audio.play();
  }else if(chordPos<=600 && chordPos>500){
    audio = minim.loadFile(chord2,512);
        audio.play();
  }else if(chordPos<=700 && chordPos>600){
    audio = minim.loadFile(chord3,512);
        audio.play(); 
  }else if(chordPos<=800 && chordPos>700){
    audio = minim.loadFile(chord4,512);
        audio.play();
  }else if(chordPos<=900 && chordPos>800){
    audio = minim.loadFile(chord5,512);
        audio.play();
  }
 
}
  
