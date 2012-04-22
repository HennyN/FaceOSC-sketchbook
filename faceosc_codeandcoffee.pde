
// an interactive advertisting for the Edinburgh Hacklab coffee & code night
// by Jannette 
// all honor belong to the following people:

// Jason Saragih's FaceTracker library 
// http://web.mac.com/jsaragih/FaceTracker/FaceTracker.html

// this template for receiving face tracking osc messages is from
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker
//
// 2012 Dan Wilcox danomatika.com
// for the IACD Spring 2012 class at the CMU School of Art (I wish I would be there...)
//
// adapted from from Greg Borenstein's 2011 example
// http://www.gregborenstein.com/
// https://gist.github.com/1603230
//
import oscP5.*;
import netP5.*;
OscP5 oscP5;

// num faces found
int found;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;

// Coffee and Code font
String date = "Thursday from 7:00pm @edinhacklab";
color tcolor = color(44, 136, 227);
color coloe;
PFont fs;

void setup() {
  size(640, 480);
  frameRate(30);
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  smooth();
}

void draw() {  
  background(255);
  //font
  eventtitle(30);
  coloe = color(random(255), random(255), random(255));
  
  if(found > 0) {
    translate(posePosition.x, posePosition.y);
    scale(poseScale);
    fill(255);
    noStroke();
    noStroke();
    stroke(255);
    fill(coloe);
    noStroke();
    rect(0, 20, mouthWidth* 5, mouthHeight * 5);
    println(mouthWidth );
    
    if(mouthWidth * 3 >10) {
       fill(coloe);
       noStroke();
       textAlign(CENTER);
       fill(tcolor);
       fs = createFont("Palatino Linotype", 18);
       textFont(fs, 18);
       text(date, 0, nostrils);
       }
     }
}

// OSC CALLBACK FUNCTIONS
public void found(int i) {
  println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
  println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if(m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}

void eventtitle(float a){
  float fluxX1 = a;
  PFont f;
  
  String codecoffee = "Coffee & Code";
 
  // font setup
    String[] fontList = PFont.list();
    f = createFont("Palatino Linotype", 48);
    fill(tcolor);
    textFont(f, 48);
    textAlign(LEFT);
    text(codecoffee, width - textWidth(codecoffee)- fluxX1 , height - fluxX1 -5);   
}
