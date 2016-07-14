class Lavender extends Vine {
  String flowerName = "lavender";
  float preAngle;
  
  public Lavender(PVector pos, int colorNo) {
    super(pos, color(169, 179, 121), colorNo);
    
    setCurve(5);
    setLeaf(6);
    setFlower(1);
    segLength = 4.5;
  }
  
  //super class method
  void setCurve(int num){
    curveNum = num;
    //curve
    curvePoint = new int[curveNum];
    for(int i=0; i<curvePoint.length; i++){
      curvePoint[i] = (int)random(100/num*i, 100/num*(i+1));
    }
  }
  
  //super class method
  void setLeaf(int num){
    leafNum = num;
    leafPoint = new int[leafNum];
    leaves = new ImageDrawer[leafNum];
    
    for(int i=0; i<leafNum; i++){
      //茎の長さを0~100とした場合の20~50の位置の間でランダムに葉の位置を決める
      leafPoint[i] = (int)random(40/num*i+10, 40/num*(i+1)+10);
      setLeafImage(i);
    }
  }
  
  //class method
  void setLeafImage(int i){
    //葉の色はランダム
    int leafColorNum = (int)random(0,2);
    if(i%2 == 0){
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum+"_L");
      leaves[i].setAngle(random(30, 40));
      leaves[i].setTrgScale(2-i*0.15);
    }else{
      leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum+"_R");
      leaves[i].setAngle(random(-30, -40));
      leaves[i].setTrgScale(2-i*0.15);
    }

  }
  
  //class method
  ImageDrawer setRandomLeaf(int leafColorNum, int order){
    if (random(0,1) < 0.5){
      return new ImageDrawer(leafImage, flowerName+leafColorNum+"_L");
    }else{
      leaves[order].setAngle(-10);
      return new ImageDrawer(leafImage, flowerName+leafColorNum+"_R");
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
      flowers[i].setTrgScale(1.5f);
      flowerPoint[i] = 100;
    }
  }
  
  //super class method
  void flowerCheck(int pointNum){
    for(int i=0; i<flowerPoint.length; i++) {
      if(pointNum == flowerPoint[i]){
        PVector diff = vinePoint.get(5).sub(vinePoint.get(6));
        float angle = atan2(diff.y, diff.x);
        angle = degrees(angle)+90;
        flowers[i].setAngle(angle);
        flowers[i].set(vinePoint.get(30).x, vinePoint.get(30).y);
      }
    }
  }
  
  //super class method
  void changeDirection(int num){
    float ang = 270;
    if(num == -1 || num == 1 || num == 2){
      ang = random(250, 290);
      
    }else if(num == 3){
      ang = random(260, 280);
    }else{
      ang = preAngle;
    }
    
    preAngle = ang;
    vec.set(new PVector(cos(radians(ang)),sin(radians(ang))));
  }
  
  void reset(){
    setCurve(5);
    super.reset();
  }
  
  
}