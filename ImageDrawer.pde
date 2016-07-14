
class ImageDrawer{
 float m_scale = 0;
 float m_trgScale = 1;
 String m_name = "";
 int m_alpha = 0;
 PVector m_pos = new PVector();
 HashMap<String, PImage> m_dic = new HashMap<String, PImage>();
 
 float angle = 0;
  
 Ani ani;
 Ani alphaAni;
 
 ImageDrawer(HashMap<String, PImage> dic,String name) {
   m_name = name;
   println("name: "+m_name);
   m_dic = dic;
 }
 
 void set(float x, float y){
   m_scale = 0;
   m_alpha = 200;
   println("name: "+m_name);
   ani = new Ani(this, 2, "m_scale", m_trgScale);
   m_pos = new PVector(x, y); 
 }
 
 void setFade(float x, float y){
   m_scale = m_trgScale;
   m_alpha = 0;
   alphaAni = new Ani(this, 1.5, "m_alpha", 255);
   m_pos = new PVector(x, y); 
 }
 
 void setAngle(float a){
   angle = a;
 }
 
 void addAngle(float a){
   angle += a;
 }
 
 void setPosition(PVector pos){
   m_pos = pos;
 }
 
 void delete(){
   alphaAni = new Ani(this, 1.5, "m_alpha", 0);
 }
 
 void reset(){
   m_pos = new PVector(-1000, -1000);
 }
 
 void drawImage(){
   if(m_dic.containsKey(m_name) == false){
     println("no key image : "+m_name);
     return;
   }
   imageMode(CENTER);
   PImage img = m_dic.get(m_name);
   if(m_alpha == 0){
     return;
   }
   tint(255,255,255, m_alpha);
   pushMatrix();
   translate(m_pos.x, m_pos.y);
   rotate(radians(angle));
   if(m_dic.containsKey("glow_c1") == true){
     //println("hoge");
     //image(img, 0, 0, img.width*m_scale, img.height*m_scale);
   }
   println(m_name+" alpha: "+m_alpha);
   image(img, 0, 0, img.width*m_scale, img.height*m_scale);
   popMatrix();
 }
 
 void setTrgScale(float s){
   m_trgScale = s;
 }
}