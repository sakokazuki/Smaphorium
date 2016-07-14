import gifAnimation.*;
import de.looksgood.ani.*;

import controlP5.*;
ControlP5 cp5;
Timer timer;

ChargePosition[] chargePos = new ChargePosition[3];

boolean isCharged0 = false;
int chargePercent0 = 20;
boolean isCharged1 = false;
int chargePercent1 = 20;
boolean isCharged2 = false;
int chargePercent2 = 20;
Textlabel frameLabel;


HashMap<String, PImage> leafImage = new HashMap<String, PImage>();
HashMap<String, PImage> flowerImage = new HashMap<String, PImage>();
HashMap<String, PImage> glowImage = new HashMap<String, PImage>();
ImageDrawer[] image = new ImageDrawer[100];

void setup() {
  size(1080, 1920);
  //size(1080, 960);
  Ani.init(this);
  setLeafImage();
  setFlowerImage();
  setGlowImage();  
  
  //for(int i=0; i<100; i++){
  //  image[i] = new ImageDrawer("rose0");
  //  image[i].set(random(width), random(height));
  //}
  //use gui?
  if (AppDefine.DRAW_GUI == true){
    cp5 = new ControlP5(this);
    setGUI();
  }
  
  timer = new Timer(1000);
  timer.start();
   
  chargePos[0] = new ChargePosition(new PVector(250, 650), 1);
  chargePos[1] = new ChargePosition(new PVector(width-250, 1130), 3);
  chargePos[2] = new ChargePosition(new PVector(250, 1580), 4);
  
  //frameRate(60);
}


void draw() {
  //println(frameRate);
  background(255);
  fill(0);
  noStroke();
  rect(0, 680, 500, 130);
  rect(width-500, 1130, 500, 130);
  rect(0, 1580, 500, 130);
  
  
  for(int i=0; i<chargePos.length; i++){
    chargePos[i].update();
  }

  if (timer.isFinished() == true) {
    checkChargeStatus();
    timer.start();
  }
  
  //for(int i=0; i<100; i++){
  //  image[i].drawImage();
  //}
  frameLabel.setText("FrameRate:"+(int)frameRate);
 
}

void checkChargeStatus(){  
  chargePos[0].setStatus(isCharged0);
  chargePos[1].setStatus(isCharged1);
  chargePos[2].setStatus(isCharged2);

  if (isCharged0 == true){
    chargePos[0].setChargePercent(chargePercent0);
  }
  if (isCharged1 == true){
    chargePos[1].setChargePercent(chargePercent1);
  }
  if (isCharged2 == true){
    chargePos[2].setChargePercent(chargePercent2);
  }

}

void setGUI(){
  Group group = cp5.addGroup("GUI")
                .setPosition(10,20)
                .setBackgroundHeight(300)
                .setWidth(300)
                .setBackgroundColor(color(0,50))
                ;
  cp5.addSlider("chargePercent0")
     .setPosition(5,45)
     .setRange(0,100)
     .setSize(200,20)
     .setGroup(group)
     ;
  cp5.addToggle("isCharged0")
     .setPosition(5,5)
     .setSize(20,20)
     .setGroup(group)
     ;
  cp5.addSlider("chargePercent1")
     .setPosition(5,125)
     .setRange(0,100)
     .setSize(200,20)
     .setGroup(group)
     ;
  cp5.addToggle("isCharged1")
     .setPosition(5,85)
     .setSize(20,20)
     .setGroup(group)
     ;
  cp5.addSlider("chargePercent2")
     .setPosition(5,205)
     .setRange(0,100)
     .setSize(200,20)
     .setGroup(group)
     ;
  cp5.addToggle("isCharged2")
     .setPosition(5,165)
     .setSize(20,20)
     .setGroup(group)
     ;
  frameLabel = cp5.addTextlabel("framelabel ")
     .setText("FrameRate:"+(int)frameRate)
     .setPosition(10,280)
     .setFont(createFont("Helvetica",20))
     ;
  
}

String[] children;
int childCount = 0;
File dir;
  

void setLeafImage(){
  dir = new File(dataPath("leaves")); 
  println(dir);

  children = dir.list();
  if (children == null) {
    println("-- file not found");
    return;
  } else {
    for (int i=0; i<children.length; i++) {
      String imageKey = split(children[i], ".")[0];
      PImage image = loadImage(dir+"/"+children[i]);
      println(imageKey);
      leafImage.put(imageKey, image);
    }
  }
  println(children.length+" files found...");
}

void setFlowerImage(){
  dir = new File(dataPath("flowers")); 
  println(dir);

  children = dir.list();
  if (children == null) {
    println("-- file not found");
    return;
  } else {
    for (int i=0; i<children.length; i++) {
      String imageKey = split(children[i], ".")[0];
      PImage image = loadImage(dir+"/"+children[i]);
      println(imageKey);
      flowerImage.put(imageKey, image);
    }
  }
  println(children.length+" files found...");
}

void setGlowImage(){
  dir = new File(dataPath("glow")); 
  println(dir);

  children = dir.list();
  if (children == null) {
    println("-- file not found");
    return;
  } else {
    for (int i=0; i<children.length; i++) {
      String imageKey = split(children[i], ".")[0];
      PImage image = loadImage(dir+"/"+children[i]);
      println(imageKey);
      glowImage.put(imageKey, image);
    }
  }
  println(children.length+" files found...");
}