class Yamabudou extends Vine {
  String flowerName = "yamabudou";
  float preAngle;
  boolean isLeft;
  
  public Yamabudou(PVector pos, int colorNo, boolean isLeft) {
    super(pos, color(145, 79, 99), colorNo);
    
    init();
    
    segLength = 7;
    this.isLeft = isLeft;
  }
  //class method
  void init(){
    setCurve(7);
    setLeaf(6);
    setFlower(1);
  }
  
  //super class method
  void setCurve(int num){
    curveNum = num;
    //curve
    curvePoint = new int[curveNum];
    for(int i=0; i<curvePoint.length; i++){
      
      curvePoint[i] = (int)random(100/num*i, 100/num*(i+1));
      if(i < 3){
        curvePoint[i] = 100/num*(i+1);
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
      leafPoint[i] = (int)random(60/num*i+40, 60/num*(i+1)+40);
      setLeafImage(i);
    }
  }
  
  //class method
  void setLeafImage(int i){
    //葉の色はランダム
    int leafColorNum = (int)random(0,2);
    if(i%2 == 0){
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum+"_L_c"+mainColorNo);
      leaves[i].setAngle(random(290,310));
      leaves[i].setTrgScale(1.2-i*0.05);
    }else{
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum+"_R_c"+mainColorNo);
      leaves[i].setAngle(random(50,70));
      leaves[i].setTrgScale(1.2-i*0.05);
    }

  }
  
  //class method
  ImageDrawer setRandomLeaf(int leafColorNum, int order){
    if (random(0,1) < 0.5){
      return new ImageDrawer(leafImage, flowerName+leafColorNum+"_L_c"+mainColorNo);
    }else{
      leaves[order].setAngle(-10);
      return new ImageDrawer(leafImage, flowerName+leafColorNum+"_R_c"+mainColorNo);
    }
  }
  
  void leafCheck(int pointNum){
    for(int i=0; i<leafPoint.length; i++) {
      if(pointNum == leafPoint[i]){        
        leaves[i].set(vinePoint.get(5).x, vinePoint.get(5).y);
      }
    }
  }
  
  //super class method
  void setFlower(int num){
    flowerNum = num;
    flowerPoint = new int[flowerNum];
    flowers = new ImageDrawer[flowerNum];
    
    for(int i=0; i<flowerNum; i++){
      flowers[i] = new ImageDrawer(flowerImage, flowerName+"_0_c"+mainColorNo);
      flowers[i].setTrgScale(1.2f);
      flowerPoint[i] = 100;
    }
  }
  
  //super class method
  void flowerCheck(int pointNum){
    for(int i=0; i<flowerPoint.length; i++) {
      if(pointNum == flowerPoint[i]){
        PVector diff = vinePoint.get(5).sub(vinePoint.get(6));
        float angle = atan2(diff.y, diff.x);
        angle = 180;
        flowers[i].setAngle(angle);
        flowers[i].set(vinePoint.get(0).x, vinePoint.get(0).y);
      }
    }
  }
  
  //super class method
  void changeDirection(int num){
    float ang = 270;
    if(num == -1){
      ang = 340;
    }else if(num == 0){
      ang = 340;
    }else if(num == 1){
      ang = 0;
    }else if(num == 2){
      ang = 30;
    }else if(num == 3){
      ang = random(50, 80);
    }else if(num == 6){
      ang = random(30, 150);
    }else if(num%2 == 0){
      ang = random(90, 150);
    }else{
      ang = random(30, 80);
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