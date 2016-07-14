class Ivy extends Vine {
  String flowerName = "ivy";
  float preAngle;
  boolean isLeft;
  
  public Ivy(PVector pos, int colorNo, boolean isLeft) {
    super(pos, color(169, 179, 121), colorNo);
    
    init();
    
    segLength = 8.5;
    this.isLeft = isLeft;
  }
  //class method
  void init(){
    setCurve(11);
    setLeaf(12);
    setFlower(0);
  }
  
  //super class method
  void setCurve(int num){
    curveNum = num;
    //curve
    curvePoint = new int[curveNum];
    for(int i=0; i<curvePoint.length; i++){
      if(i<8){
        curvePoint[i] = i*10;
      }else if(i == 8){
        curvePoint[i] = 92;
      }else if(i == 9){
        curvePoint[i] = 97;
      }else if(i == 10){
        curvePoint[i] = 99;
      }
    }
  }
  
  //super class method
  void setLeaf(int num){
    leafNum = num;
    leafPoint = new int[leafNum];
    leaves = new ImageDrawer[leafNum];
    
    for(int i=0; i<leafNum; i++){
      //茎の長さを0~100とした場合の20~80の位置の間でランダムに葉の位置を決める
      leafPoint[i] = (int)random(90/num*i+10, 90/num*(i+1)+10);
      setLeafImage(i);
    }
  }
  
  //class method
  void setLeafImage(int i){
    //葉の色はランダム
    int leafColorNum = (int)random(0,2);
    if(i%2 == 0){
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum);
      leaves[i].setAngle(random(290,310));
      leaves[i].setTrgScale(1.3-i*0.01);
    }else{
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum);
      leaves[i].setAngle(random(50,70));
      leaves[i].setTrgScale(1.3-i*0.03);
    }

  }
  
  //class method
  ImageDrawer setRandomLeaf(int leafColorNum, int order){
    if (random(0,1) < 0.5){
      return new ImageDrawer(leafImage, flowerName+leafColorNum);
    }else{
      leaves[order].setAngle(-10);
      return new ImageDrawer(leafImage, flowerName+leafColorNum);
    }
  }
  
  void leafCheck(int pointNum){
    for(int i=0; i<leafPoint.length; i++) {
      if(pointNum == leafPoint[i]){
        PVector diff = vinePoint.get(5).sub(vinePoint.get(6));
        float angle = atan2(diff.y, diff.x);
        float isLeftRandomNum = random(0, 1);
        if(isLeftRandomNum<0.5){
          angle = degrees(angle) + random(-60, -40);
        }else{
          angle = degrees(angle) + random(40, 60);
        }
        
        leaves[i].setAngle(angle);
        leaves[i].set(vinePoint.get(5).x, vinePoint.get(5).y);
      }
    }
  }
  

  //super class method
  void changeDirection(int num){
    float ang = preAngle;
    if(num == -1){
      ang = 340;
    }else if(num == 1){
      ang = 310;
    }else if(num == 2){
      ang = 300;
    }else if(num == 3){
      ang = 0;
    }else if(num == 4){
      ang = random(30, 70);
    }else if(num == 6){
      ang = 90;
    }else if(num == 7){
      ang = random(100, 120);
    }else if(num == 8){
      ang = 0;
    }else if(num == 9){
      ang = 270;
    }else if(num == 10){
      ang = 210;
    }
   
    if(isLeft == false){
      ang = 180+(360-ang);
    }
    
    
    preAngle = ang;
    vec.set(new PVector(cos(radians(ang)),sin(radians(ang))));
  }
  
  void reset(){
    init();
    super.reset();
  }
  
}