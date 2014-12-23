class Brick{
       int brickX;
       int brickY;
       //float bGap;
       //color bColor;
       int bWidth=40;
       int bHeight=10;
       boolean gone = false; 
       

       void display(){
          fill(random(255),255,255);
          rectMode(CENTER);
          rect(brickX,brickY,bWidth,bHeight);
                 
         }
      Brick(int x,int y){
        brickX=x;
        brickY=y;
        
      }
}
