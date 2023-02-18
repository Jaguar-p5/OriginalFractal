/* void start(){
  size(500, 500);

}


float f = 1 ;
void draw(){
 background(255);
 fib(0, height, 1000);
 f *= 1.01;
 if(f>=2) f = 1;
}
void fib(float x, float y, float n){
 if(n <= 12){n = 8*f; fill(x*255.0/500.0, y*255.0/500.0, (x+y)/2.0*255.0/500.0); triangle(x, y, x + n/2, y - n*0.8, x + n, y);}
  else {
    fib(x, y, n/2);
    fib(x+n*f/4, y-n*f*0.4, n/2);
    fib(x+n*f/2, y, n/2);
  }
 
}
*/


int endR = 155;
int endG = 55;
int endB = 0;
int startR = 24;
int startG = 134;
int startB = 35;
int storeR = 0;
int storeG = 0;
int storeB = 0;


boolean[] keys;
Tree bob;
Slider sue;
Slider tim;
Slider rSlide;
Slider gSlide;
Slider bSlide;

void setup(){
 size(1000, 1000);
 keys = new boolean[222];
  bob = new Tree(15, 2, PI/11, 0.85, 70, 350, 500);
  sue = new Slider(45, 45, 255, 50, 10);
  tim = new Slider(395, 45, 255, 50, 10);
  rSlide = new Slider(415, 400, 255, 40, 0);  
  gSlide = new Slider(415, 475, 255, 40, 0);
  bSlide = new Slider(415, 550, 255, 40, 0);
}
// Want tree class: needs variables, draw, increment

void keyPressed(){

  if(keyCode == 90) isAuto = !isAuto;
  if(keyCode == 88){
   startR = storeR;
   startG = storeG;
   startB = storeB;
    
  }
  if(keyCode == 67){
   endR = storeR;
   endG = storeG;
   endB = storeB;
    
  }
  keys[keyCode] = true;
  
 
}
void mousePressed(){
  sue.checkNewHeld();
  tim.checkNewHeld();
  rSlide.checkNewHeld();
  gSlide.checkNewHeld();
  bSlide.checkNewHeld();
 
}
void mouseReleased(){
  sue.isHeld = false;
  tim.isHeld = false;
 
}
void keyReleased(){
 keys[keyCode] = false;
}
boolean isAuto = false;
boolean revAuto = false;
boolean isAdvancedColor = false;
int control = 0;
void draw(){
  background(155);
  if(isAuto){
  if(revAuto) {  control = control -1; if(control <= 0) revAuto = false;}
  else{
   control ++;
   if(control >= 255){ revAuto = true;}
  }
  sue.slideX = control;
  tim.slideX = control;
  }
  else{
  stroke(0);
  sue.updateState();
  sue.changeSlide();
  sue.show();
  tim.updateState();
  tim.changeSlide();
  tim.show();
  rSlide.updateState();
  rSlide.changeSlide();
  rSlide.show();
  bSlide.updateState();
  bSlide.changeSlide();
  bSlide.show();
  gSlide.updateState();
  gSlide.changeSlide();
  gSlide.show();
  storeR = (int)rSlide.slideX;
  storeG = (int)gSlide.slideX;
  storeB = (int)bSlide.slideX;
  fill(storeR, storeG, storeB);
  strokeWeight(3);
  stroke(0);
  ellipse(width - 200, height - 50, 75, 75);
  
  fill(startR, startG, startB);
  strokeWeight(3);
  stroke(0);
  ellipse(width - 600, height - 50, 75, 75);
  
  fill(endR, endG, endB);
  strokeWeight(3);
  stroke(0);
  ellipse(width - 400, height - 50, 75, 75);
  
  
  }
  bob.myCol = color(startR +( (tim.slideX/255) * (endR - startR)) , startG + ((tim.slideX/255) * (endG - startG)), startB + ( (tim.slideX/255) * (endB - startB)));
  bob.angleChange =  sue.slideX/255 * PI/11 + PI/22;
  bob.show();

}

boolean getState(int theKey){
 return keys[theKey];
 
}
class Slider{
  float myX, myY , myYSize, myXSize;
  color myCol;
  boolean isHeld;
  float slideX;
  float slideMargin;
  public Slider(float x, float y, float xSize, float ySize, float margin){
   isHeld = false;
   myCol = 255;
   myX = x;
   myY = y;
   myXSize = xSize;
   myYSize = ySize;
   slideX = 100;
   slideMargin = margin;
  }
  void show(){
   fill(myCol);
   rect(myX, myY, myXSize, myYSize);
   ellipse(slideX + myX, myY + myYSize/2, myYSize, myYSize);
  }
  void changeSlide(){
   float mX = mouseX;
   if(mX < myX) mX = myX;
   if(mX > myX + myXSize) mX = myX + myXSize;
 
   
    if(isHeld)slideX = mX - myX;
   
  }
  void updateState(){
   
    if(!safeMouseIn()) isHeld = false;
  }
  void checkNewHeld(){ if(safeMouseIn()) isHeld = true;}
  boolean safeMouseIn(){
    if(mouseX < myX - slideMargin) return false;
   if(mouseX > myX + myXSize + slideMargin/5) return false;
   if(mouseY < myY - slideMargin) return false;
   if(mouseY > myY + myYSize + slideMargin/5) return false;
    return true;
  }
   
 
  boolean mouseIn(){
   if(mouseX < myX) return false;
   if(mouseX > myX + myXSize) return false;
   if(mouseY < myY) return false;
   if(mouseY > myY + myYSize) return false;
    return true;
  }
}
class Tree{
float min;
int nBranches;
float angleChange;
float sizeChange;
float len;
float myX;
float myY;
color myCol;
public Tree(float _min, int _nBranches, float _angleChange, float _sizeChange, float _len,  float x, float y){
  min = _min;
  nBranches = _nBranches;
  angleChange = _angleChange;
  sizeChange = _sizeChange;
  len = _len;
  myX = x;
  myY = y;
  myCol = color(0, 0, 0);
 
 
}

void show(){
  stroke(myCol);
  strokeWeight(1.7);
f(myX, myY, -PI/2, len);

 
 
}

 void f(float x, float y, float theta, float len){

  if(len < min) return;
  line(x, y, x + len*cos(theta + angleChange), y + len*sin(theta + angleChange));
  f(x + len*cos(theta + angleChange), y + len*sin(theta + angleChange), theta + angleChange, len*sizeChange);
  line(x, y, x + len*cos(theta - angleChange), y + len*sin(theta - angleChange));
  f(x + len*cos(theta - angleChange), y + len*sin(theta - angleChange), theta - angleChange, len*sizeChange);
 
  }

}
