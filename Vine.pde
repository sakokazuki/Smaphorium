class Vine {
  ArrayList<PVector> vinePoint = new ArrayList<PVector>();
  
  float segLength = 4;
  color vineCol; //<>//
  
  PVector initPos = new PVector();
  PVector topPos = new PVector();
  PVector vec = new PVector();

  float growSpeed = 1;
  VineState m_state = VineState.Wait;
  
  int mainColorNo = 0;
  
  int targetPercent = 0;
  int nowPercent = 0;
  
  //Vine
  int curveNum = 0;
  int[] curvePoint;
  int vineAlpha;
  
  //Leaf
  int leafNum = 0;
  int[] leafPoint;
  ImageDrawer[] leaves;
  
  //flower
  int flowerNum = 0;
  int[] flowerPoint;
  ImageDrawer[] flowers;
  
  Timer deletingTimer;
  int deleteDuration = 1000;
  
  boolean isComplete = false;
  
  Vine(PVector pos, color col, int colorNo){
    initPos.set(pos);
    topPos.set(pos);
    vineCol = col;
    mainColorNo = colorNo;
    
    vineAlpha = 255;
    
    deletingTimer = new Timer(deleteDuration);
    deletingTimer.start();
    
    vinePoint.add(initPos);
    
  }
  
  
  
  void update(){  
    ////////////////////////////////////////////////////////////
    //State = wait
    ////////////////////////////////////////////////////////////
    if(m_state == VineState.Wait){
      
    ////////////////////////////////////////////////////////////
    //State = grow
    ////////////////////////////////////////////////////////////
    }else if (m_state == VineState.Grow){
      if (vinePoint.size() == 0){
        return; 
      }

      float dist = vinePoint.get(vinePoint.size()-1).dist(initPos);
      if (dist >= segLength  && isComplete == false){
        vinePoint.add(initPos);
        curveCheck(vinePoint.size());
        
        leafCheck(nowPercent);
        leafPositionUpdate();
        
        flowerCheck(nowPercent);
        
        if (nowPercent == AppDefine.MAX_CHARGE_PERCENT){
          isComplete = true;
          println("complete!");
        }
      }      
    
      //draw vine
      for(int i=1; i<vinePoint.size(); i++) {
       dragSegment(i);
      }
      
      
      //data update
      if(nowPercent <= targetPercent && isComplete == false){
        topPos.x += growSpeed*vec.x;
        topPos.y += growSpeed*vec.y;
        vinePoint.set(0, topPos);
        nowPercent = vinePoint.size();
      }
      
    ////////////////////////////////////////////////////////////
    //State = delete
    ////////////////////////////////////////////////////////////
    }else if (m_state == VineState.Delete){
      //draw vine
      
      vineAlpha-=5;
      for(int i=1; i<vinePoint.size(); i++) {
        dragSegment(i);
      }
      
      //delete -> wait
      if (deletingTimer.isFinished() == true) {
        m_state = VineState.Wait;
        reset();
      }
    }
    
    ////////////////////////////////////////////////////////////
    //ALL STATE 
    ////////////////////////////////////////////////////////////
    
    //draw leaf
    for(int i=0; i<leaves.length; i++){
      leaves[i].drawImage();
    }
    
    //draw flower
    for(int i=0; i<flowers.length; i++){
     flowers[i].drawImage();
    }
    
  }
  /*--------------------
  /reset
  --------------------*/
  void reset(){
    isComplete = false;
    vinePoint.clear();

    topPos.set(initPos);
    vinePoint.add(initPos);
    vineAlpha = 255;
    
    leafReset();
    flowerReset();
    
    targetPercent = 0;
    nowPercent = 0;
  }
  
  /*--------------------
  /state 
  --------------------*/
  void changeState(VineState state){
    m_state = state;
    //println("changeState: "+m_state);
    
    if(m_state == VineState.Delete){
      deletingTimer.start();
      leafDelete();
      flowerDelete();
    }
    
    if(m_state == VineState.Grow){
      changeDirection(-1);
    }
  }
  
  VineState getState(){
    return m_state;
  }
  
  /*--------------------
  /growing functions
  --------------------*/
  
  /*---------------
  /CURVE
  ---------------*/
  void setCurve(int num){
    curveNum = num;
    //curve
    curvePoint = new int[curveNum];
    for(int i=0; i<curvePoint.length; i++){
      curvePoint[i] = (int)random(100);
    }
  }
  
  void curveCheck(int pointNum){
    for(int i=0; i<curvePoint.length; i++) {
      if(pointNum == curvePoint[i]){
        changeDirection(i);
      }
    }
  }
  
  void changeDirection(int num){
    float ang = random(180, 360);
    vec.set(new PVector(cos(radians(ang)),sin(radians(ang))));
  }  
  
  /*---------------
  /LEAF
  ---------------*/
  void setLeaf(int num){
    leafNum = num;
    leafPoint = new int[leafNum];
    leaves = new ImageDrawer[leafNum];
    
    for(int i=0; i<leafNum; i++){
      leaves[i] = new ImageDrawer(leafImage, "rose0_R");
      leafPoint[i] = 100/leafNum * i+10;
    }
  }
  
  void leafCheck(int pointNum){
    for(int i=0; i<leafPoint.length; i++) {
      if(pointNum == leafPoint[i]){
        PVector diff = vinePoint.get(5).sub(vinePoint.get(6));
        float angle = atan2(diff.y, diff.x);
        angle = degrees(angle)+90;

        if(angle > 30){
        angle = random(10, 30);
        }
        if(angle < -30){
        angle = random(-30, -10);
        }
        leaves[i].setAngle(angle);
        
        leaves[i].set(vinePoint.get(5).x, vinePoint.get(5).y);
      }
    }
  }
  
  void leafPositionUpdate(){    
    for(int i=0; i<leafPoint.length; i++) {
      
      if(nowPercent >= leafPoint[i]){
        int n = nowPercent - leafPoint[i] + 5;
        leaves[i].setPosition(vinePoint.get(n));
      }
    }
  }
  
  void leafDelete(){
    for(int i=0; i<leaves.length; i++) {
      leaves[i].delete();
    }
  }
  
  void leafReset(){
    for(int i=0; i<leaves.length; i++) {
      leaves[i].reset();
    }
  }
  
  /*---------------
  /FLOWER
  ---------------*/
  void setFlower(int num){
    flowerNum = num;
    flowerPoint = new int[flowerNum];
    flowers = new ImageDrawer[flowerNum];
    
    for(int i=0; i<flowerNum; i++){
      flowers[i] = new ImageDrawer(flowerImage, "rose_0_c0");
      flowerPoint[i] = 100;
      println("serflower"+flowerPoint[i]);
    }
  }
  
  void flowerCheck(int pointNum){
    for(int i=0; i<flowerPoint.length; i++) {
      if(pointNum == flowerPoint[i]){
        PVector diff = vinePoint.get(5).sub(vinePoint.get(6));
        float angle = atan2(diff.y, diff.x);
        angle = degrees(angle)+90;
        flowers[i].setAngle(angle);
        flowers[i].set(vinePoint.get(0).x, vinePoint.get(0).y);
      }
    }
  }
  
  void flowerDelete(){
    for(int i=0; i<flowers.length; i++) {
      flowers[i].delete();
    }
  }
  
  void flowerReset(){
    for(int i=0; i<flowers.length; i++) {
      flowers[i].reset();
    }
  }
  
 
  
  
  void dragSegment(int i) {
    float dx = vinePoint.get(i-1).x - vinePoint.get(i).x;
    float dy = vinePoint.get(i-1).y - vinePoint.get(i).y;
    float angle = atan2(dy, dx);
    
    float newPointX = vinePoint.get(i-1).x - cos(angle) * segLength;
    float newPointY = vinePoint.get(i-1).y - sin(angle) * segLength;
    vinePoint.set(i, new PVector(newPointX, newPointY));
    segment(vinePoint.get(i), angle, i);
  }
  
  void segment(PVector inVec, float a, int weight) {
    pushMatrix();
    translate(inVec.x, inVec.y);
    rotate(a);
    strokeWeight(3+(int)weight/10);
    stroke(red(vineCol)-weight, green(vineCol)-weight, blue(vineCol)-weight, vineAlpha);
    line(0, 0, segLength, 0);
    popMatrix();
  }
  
  void setTargetPercent(int percent){
    if (isComplete == true || percent > AppDefine.MAX_CHARGE_PERCENT || percent < 0){
      //println("setTargetPercent error (percent: "+ percent+")");
      return;
    } 
    
    targetPercent = percent;  
  }
  
  int getPercent(){
    return nowPercent;
  }

}