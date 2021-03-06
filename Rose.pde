class Rose extends Vine {
  String flowerName = "rose";

  public Rose(PVector pos, int colorNo) {
    super(pos, color(169, 179, 121), colorNo);
    
    setCurve(5);
    setLeaf(10);
    setFlower(1);
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
      //leaves[i] = new ImageDrawer("rose0_L");
      //茎の長さを0~100とした場合の20~90の位置の間でランダムに葉の位置を決める
      leafPoint[i] = (int)random(70/num*i+20, 70/num*(i+1)+20);
      setLeafImage(i);
    }
  }
  
  //class method
  void setLeafImage(int i){
    /*以下のどれかから葉っぱの画像の名前を選択
    /rose0_L.png
    /rose0_R.png
    /rose1_L.png
    /rose1_R.png
    */
    
    //葉の色はランダム
    int leafColorNum = (int)random(0,2);
    //ひとつ目はLRランダム
    if(i == 0){
      leaves[i] = setRandomLeaf(leafColorNum);
      return;
    }
    
    //2つめ以降、距離が8以下だったら(お互いの距離が近過ぎたら、LR反対側のものを選択)
    if(leafPoint[i] - leafPoint[i-1] < 8){
      if(leaves[i-1].m_name.indexOf("_R") != -1){
        leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum+"_L");
      }else{
        leaves[i] = new ImageDrawer(leafImage, flowerName+leafColorNum+"_R");
      }
      
      return;
    }   
    
    //それ以外はLRランダム
    leaves[i] = setRandomLeaf(leafColorNum); 
  }
  
  //class method
  //ランダムに花を咲かせる場合
  ImageDrawer setRandomLeaf(int leafColorNum){
    if (random(0,1) < 0.5){
      return new ImageDrawer(leafImage, flowerName+leafColorNum+"_L");
    }else{
      return new ImageDrawer(leafImage, flowerName+leafColorNum+"_R");
    }
  }
               
  //super class method
  void setFlower(int num){
    flowerNum = num;
    flowerPoint = new int[flowerNum];
    flowers = new ImageDrawer[flowerNum];
    for(int i=0; i<flowerNum; i++){
      flowers[i] = new ImageDrawer(flowerImage, flowerName+"_0_c"+mainColorNo);
      flowerPoint[i] = 100;
    }
  }
  
  //super class method
  void changeDirection(int num){
    float ang = random(290, 330);
    if(num%2 == 1){
      ang = random(210, 250);
    }
    vec.set(new PVector(cos(radians(ang)),sin(radians(ang))));
  }
  
  void reset(){
    setCurve(5);
    super.reset();
  }
  
  
}