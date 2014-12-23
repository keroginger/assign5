Ball ball;
Bar board;
//Brick brick;
Brick[] bricks;

//Game Status
final int GAME_START   = 0;
final int GAME_PLAYING = 1;
final int GAME_WIN     = 2;
final int GAME_LOSE    = 3;

int status;     //Game Status
int point;      //Game Score
int brickNum;   //Breaking brick number
int pLife=3;

void setup(){
  
   status = GAME_START;
   
  size(640,480);
   ball= new Ball(mouseX,height-18);
   board = new Bar(100);
   bricks = new Brick[50];
    reset();
   
 //    for(int i=0;i<bricks.length;i++){
 //      bricks[i]= new Brick(105,40);
 //    }
   //brick= new Brick(240,40))
}
void draw(){
   background(0);
   switch(status) {

      case GAME_START:
        
        ball.display();
        board.display();
        board.move();
        ball = new Ball(mouseX,height-18);
        for (int i=0; i<bricks.length; i++){
        bricks[i].display();
        pongLife(3);
       }
      break;
      case GAME_PLAYING:
      
       ball.move();
       ball.display();
       board.move();
       drawBrick();
       pongLife(3);
       ballDrop();
       board.display();
       shotBrick();
       /*for (int i=0; i<bricks.length; i++){
         bricks[i].display();
       }*/
       //brick.display(100);
      break;
      case GAME_WIN:
      break;
      case GAME_LOSE:
       background(255);
       
      break;
  
   }
} 
void pongLife(int life) {
    fill(230, 74, 96);
    textSize(16);
    text("LIFE :", 36, 455); 
    int lifeX=88;
    int lifeY=448;
    int lifeGap=25;
    for(int i=0;i<pLife;i++){
      fill(230, 74, 96);
      noStroke();
      ellipse(lifeX+(lifeGap*i),lifeY,15,15);
  }
}

void drawBrick() {
  for (int i=0; i<bricks.length; i++) {
    Brick brick = bricks[i];
    if (brick!=null) {
      brick.display(); //Draw Brick
      /*---------Call Check Line Hit---------*/
      //lineHit(alien.aY);
      /*--------------------------------------*/
    }
  }
}
void brickMaker(int x,int y,int spacing,int bInRow){
    for (int i=0;i<bricks.length;++i){
    
    float row = i / bInRow;
    float col = i % bInRow;
    int bX = x + (spacing*int(col));
    int bY = y + (spacing*int(row));
    bricks[i]= new Brick(bX,bY);
    
}
}
void ballDrop(){
   if(ball.y==480){
      pLife--;
      status = GAME_START;
   }
   if(pLife==0){
      status = GAME_LOSE;
   }
}

void shotBrick(){
 for (int i=0; i<bricks.length; i++) {
    Brick brick = bricks[i];
    if ( brick!= null && !brick.gone && // Check Array isn't empty and brick still exist
      bricks[i].brickX+brick.bWidth/2 >= ball.x  && bricks[i].brickY-brick.bWidth/2<= ball.y+ball.size/2
     && bricks[i].brickX-brick.bWidth/2<=ball.x && bricks[i].brickY+brick.bWidth/2>= ball.y  ) {
      
      
      removeBrick(brick);
      brickNum++;
    }
  }
}
void removeBrick(Brick obj) {
  obj.gone = true;
  obj.brickX = 1000;
  obj.brickY = 1000;
}

/*---------Reset Game-------------*/
void reset() {
  for (int i=0; i<bricks.length-1; i++) {
    bricks[i] = null;
  }
  brickMaker(105,40,41,10);
  point = 0;

}
void mouseClicked(){
     if(mouseButton==RIGHT){
         status = GAME_PLAYING;
     }
}


