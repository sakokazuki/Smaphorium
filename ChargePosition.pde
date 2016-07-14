class ChargePosition{
  boolean m_isCharged = false;
  PVector m_pos = new PVector();
  boolean m_isLeft = true;
  int m_colorNum;
  
  //Gif alertAnim;
  
  Vine[] m_vines;
  ImageDrawer m_glow;
  
  
  ChargePosition(PVector pos, int colorNum){
    m_pos.set(pos);
    m_vines = new Vine[AppDefine.MAX_FLOWER_NUM];
    m_colorNum = colorNum;
    m_glow = new ImageDrawer(glowImage, "glow_c"+colorNum);
    m_glow.setTrgScale(1.5f);
    
    if(pos.x > width/2){
      m_isLeft = false;
    }
    setVine(); 
    
    
  }
  
  void setVine(){
    for(int i=0; i<m_vines.length; i++){
      if (i==0){
        m_vines[i] = new Clover(m_pos.add(new PVector(i*30.0, 0.0)), m_colorNum, m_isLeft);
      }else if(i == 1){
        m_vines[i] = new Rose(m_pos.add(new PVector(i*30.0, 0.0)), m_colorNum);
      }else if(i == 2){
        m_vines[i] = new Gerbera(m_pos.add(new PVector(i*30.0, 0.0)), m_colorNum);
      }else if(i == 3){
        m_vines[i] = new Lavender(m_pos.add(new PVector(i*30.0, 0.0)), m_colorNum);
      }else if(i == 4){
        m_vines[i] = new Yamabudou(m_pos.add(new PVector(i*30.0, 0.0)), m_colorNum, m_isLeft);
      }

    }
  }
  
  void update(){
    m_glow.drawImage();
    for(int i=0; i<m_vines.length; i++){
      m_vines[i].update();
    }
  }
  
  void setChargePercent(int percent){
    // ex percent = 65
    // 100 / 5 = 20
    int plantMaxPercent = AppDefine.MAX_CHARGE_PERCENT / AppDefine.MAX_FLOWER_NUM;
    // (ex) 65 / 20 = 3
    int completePlantNum = percent / plantMaxPercent;
    // (ex) 65 % 20 = 5
    int lastPlantPercent = percent % plantMaxPercent;
    
    
    for(int i=0; i<completePlantNum; i++){
      m_vines[i].setTargetPercent(100);
    }
    
    //100%
    if(completePlantNum == AppDefine.MAX_FLOWER_NUM){
      return;
    }
    
    m_vines[completePlantNum].setTargetPercent(100*lastPlantPercent/plantMaxPercent);
  }
  
  void setStatus(boolean isCharged){
    //充電ステータスかわったときだけグローの処理
    if(m_isCharged != isCharged){
      if(isCharged == true){
        m_glow.setFade(m_pos.x-250, m_pos.y-150);
      }else{
        m_glow.delete();
      }
    }
    m_isCharged = isCharged;
    
    if(m_isCharged == true){
      for(int i=0; i<m_vines.length; i++){
        if(m_vines[i].getState() == VineState.Wait){
          m_vines[i].changeState(VineState.Grow);
        }
      }
    } else {
      for(int i=0; i<m_vines.length; i++){
        if(m_vines[i].getState() == VineState.Grow){
          m_vines[i].changeState(VineState.Delete);
        }
      }
    }
  }

}