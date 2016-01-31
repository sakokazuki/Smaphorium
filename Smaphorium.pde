import controlP5.*;
ControlP5 cp5;
Timer timer;

ChargePosition chargePos;

boolean isCharged = false;
int chargePercent = 50;

void setup() {
  size(1280, 640);
  
  //use gui?
  if (AppDefine.DRAW_GUI == true){
    cp5 = new ControlP5(this);
    setGUI();
  }
  
  timer = new Timer(1000);
  timer.start();
   
  chargePos = new ChargePosition(new PVector(width/2, height));
}


void draw() {
  background(255);
  
  chargePos.update();

  if (timer.isFinished() == true) {
    checkChargeStatus();
    timer.start();
  }
}

void checkChargeStatus(){  
  chargePos.setStatus(isCharged);
  if (isCharged == true){
    chargePos.setChargePercent(chargePercent);
  }
}

void setGUI(){
  Group group = cp5.addGroup("GUI")
                .setPosition(10,20)
                .setBackgroundHeight(100)
                .setWidth(300)
                .setBackgroundColor(color(0,50))
                ;
  cp5.addSlider("chargePercent")
     .setPosition(5,45)
     .setRange(0,100)
     .setSize(200,20)
     .setGroup(group)
     ;
  cp5.addToggle("isCharged")
     .setPosition(5,5)
     .setSize(20,20)
     .setGroup(group)
     ;
}