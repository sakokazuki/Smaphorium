class Clover extends Vine {
  String flowerName = "clover";
  float preAngle;
  boolean isLeft;
  
  public Clover(PVector pos, int colorNo, boolean isLeft) {
    super(pos, color(169, 179, 121), colorNo);
    
    init();
    
    segLength = 6.5;
    this.isLeft = isLeft;
  }
  //class method
  void init(){
    setCurve(10);
    setLeaf(16);
    setFlower(6);
  }
  
  //super class method
  void setCurve(int num){
    curveNum = num;
    //curve
    curvePoint = new int[curveNum];
    for(int i=0; i<curvePoint.length; i++){
      curvePoint[i] = i*10;
    }
  }
  
  //super class method
  void setLeaf(int num){
    leafNum = num;
    leafPoint = new int[leafNum];
    leaves = new ImageDrawer[leafNum];
    
    for(int i=0; i<leafNum; i++){
      //茎の長さを0~100とした場合の20~80の位置の間でランダムに葉の位置を決める
      leafPoint[i] = (int)random(100/num*i+10, 100/num*(i+1)+10);
      setLeafImage(i);
    }
  }
  
  //class method
  void setLeafImage(int i){
    //葉の色はランダム
    int leafColorNum = (int)random(0,2);
    if(i%2 == 0){
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum);
      leaves[i].setTrgScale(2-i*0.05);
    }else{
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum);
      leaves[i].setTrgScale(2-i*0.05);
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
        
        float r = random(-30, 30);
        float x = r*cos(angle+PI/2);
        float y = r*sin(angle+PI/2);
        leaves[i].setAngle(random(0, 360));
          
        float leafPosX = vinePoint.get(4).x + x;
        float leafPosY = vinePoint.get(4).y + y;
  
        leaves[i].set(leafPosX, leafPosY);
      }
    }
  }
  
  //位置調整しない
  //super class method
  void leafPositionUpdate(){
  }
  
  //super class method
  void setFlower(int num){
    flowerNum = num;
    flowerPoint = new int[flowerNum];
    flowers = new ImageDrawer[flowerNum];
    
    for(int i=0; i<flowerNum; i++){
      flowers[i] = new ImageDrawer(flowerImage, flowerName+"_0_c"+mainColorNo);
      flowers[i].setTrgScale(1f);
      flowerPoint[i] = (int)random(20, 100);
    }
  }
  
  //super class method
  void flowerCheck(int pointNum){
    for(int i=0; i<flowerPoint.length; i++) {
      if(pointNum == flowerPoint[i]){
        PVector diff = vinePoint.get(5).sub(vinePoint.get(6));
        float angle = atan2(diff.y, diff.x);
        
        float r = random(-30, 30);
        float x = r*cos(angle+PI/2);
        float y = r*sin(angle+PI/2);
        flowers[i].setAngle(random(0, 360));
          
        float flowerPosX = vinePoint.get(6).x + x;
        float flowerPosY = vinePoint.get(6).y + y;
  
        flowers[i].set(flowerPosX, flowerPosY);
      }
    }
  }


  //super class method
  void changeDirection(int num){
    float ang = preAngle;
    boolean usePreAngle = true;
    if(num == -1){
      ang = 350;
      usePreAngle = false;
    }else if(num == 1){
      ang = 0;
      usePreAngle = false;
    }else if(num == 5){
      ang = random(80, 100);
      usePreAngle = false;
    }else if(num == 8){
      ang = random(70, 110);
      usePreAngle = false;
    }
   
    if(isLeft == false && usePreAngle == false){
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