void start(){
  size(500,500);

}


float f = 1 ;
void draw(){
 background(0);
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
