class ChargePosition{
  boolean m_isCharged = false;
  PVector m_pos = new PVector();
  
  Vine[] m_vines;
  
  ChargePosition(PVector pos){
    m_pos.set(pos);
    m_vines = new Vine[AppDefine.MAX_FLOWER_NUM];
    setVine(); 
    
  }
  
  void setVine(){
    for(int i=0; i<m_vines.length; i++){
      if (i%2 == 0){
        m_vines[i] = new Rose(m_pos.add(new PVector(i*10.0, 0.0)));
      }else{
        m_vines[i] = new Clover(m_pos.add(new PVector(i*10.0, 0.0)));
      }
    }
  }
  
  void update(){
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
    m_vines[completePlantNum].setTargetPercent(lastPlantPercent);
  }
  
  void setStatus(boolean isCharged){
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