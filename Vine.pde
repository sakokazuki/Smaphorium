class Vine {
  ArrayList<PVector> vinePoint = new ArrayList<PVector>();
  
  float segLength = 5;
  color vineCol;
  
  PVector initPos = new PVector();
  PVector topPos = new PVector();
  PVector vec = new PVector();
  float growSpeed = 1;
  VineState m_state = VineState.Wait;
  
  int targetPercent;
  int nowPercent = 0;
  
  int curveNum = 5;
  int[] curvePoint;
  
  int vineAlpha;
  //int[] leafPoint;
  //int[] flowerPoint;
  
  Timer deletingTimer;
  int deleteDuration = 1000;
  
  boolean isComplete = false;
  
  Vine(PVector pos, color col){
    initPos.set(pos);
    topPos.set(pos);
    vineCol = col;
    
    vineAlpha = 255;
    
    deletingTimer = new Timer(deleteDuration);
    deletingTimer.start();
    float ang = random(210, 330);
    vec = new PVector(cos(radians(ang)),sin(radians(ang)));
    
    vinePoint.add(initPos);
    
    curvePoint = new int[curveNum];
    for(int i=0; i<curvePoint.length; i++){
      curvePoint[i] = (int)random(100);
    }
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
      if (dist >= segLength){
        vinePoint.add(initPos);
        curveCheck(vinePoint.size());
        
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
  }
  /*--------------------
  /reset
  --------------------*/
  void reset(){
    isComplete = false;
    vinePoint.clear();
    
    float ang = random(210, 330);
    vec = new PVector(cos(radians(ang)),sin(radians(ang)));
    topPos.set(initPos);
    vinePoint.add(initPos);
    vineAlpha = 255;
    
    for(int i=0; i<curvePoint.length; i++){
      curvePoint[i] = (int)random(100);
    }
  }
  
  /*--------------------
  /state 
  --------------------*/
  void changeState(VineState state){
    m_state = state;
    //println("changeState: "+m_state);
    
    if(m_state == VineState.Delete){
      deletingTimer.start();
    }
  }
  
  VineState getState(){
    return m_state;
  }
  
  /*--------------------
  /growing functions
  --------------------*/
  void curveCheck(int pointNum){
    for(int i=0; i<curvePoint.length; i++) {
      if(pointNum == curvePoint[i]){
        changeDirection();
      }
    }
  }
  
  void changeDirection(){
    float ang = random(180, 360);
    vec.set(new PVector(cos(radians(ang)),sin(radians(ang))));
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
    strokeWeight(3+(int)weight/5);
    stroke(vineCol, vineAlpha);
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