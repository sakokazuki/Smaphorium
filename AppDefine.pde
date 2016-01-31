static class AppDefine {
  static int CHARGE_POS_NUM = 3;
  static int MAX_FLOWER_NUM = 5;
  static int MAX_CHARGE_PERCENT = 100;
  static boolean DRAW_GUI = true; 
}

enum VineState{
  Wait,
  Grow,
  Delete,
}


enum eFlower {
 rose(0), 
   clover(1);

 private int number;

 eFlower(int number) {
   this.number = number;
 }

 public int getNumber() {
   return this.number;
 }
}

enum eColor {
 normal(0), 
   pink(1), 
   red(2), 
   purple(3), 
   blue(4), 
   lightblue(5), 
   yellow(6), 
   orange(7);

 private int number;

 eColor(int number) {
   this.number = number;
 }

 public int getNumber() {
   return this.number;
 }
}