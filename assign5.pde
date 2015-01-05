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
int brickNum;   //Breaking brick number
int pLife=3;
boolean start=false;
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
        noStroke();
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(23);
        text("Press Enter or Click Right ", width/2, height/2+20);
        ball.display();
        board.display();
        board.move();
        ball = new Ball(mouseX,height-18);
        for (int i=0; i<bricks.length; i++){
        bricks[i].display();
        drawLife();
       }
      break;
      case GAME_PLAYING:
      
       ball.move();
       ball.display();
       board.move();
       drawBrick();
       drawLife();
       ballDrop();
       board.display();
       shotBrick();
       checkWin();
      
      break;
      case GAME_WIN:
         background(255);
         noStroke();
         fill(230, 74, 96);
         textAlign(CENTER, CENTER);
         textSize(48);
         text("YOU WIN!!!!", width/2, height/2);
      break;
      case GAME_LOSE:
         background(255);
         noStroke();
         fill(230, 74, 96);
         textAlign(CENTER, CENTER);
         textSize(48);
         text("PLAY AGAIN!!!", width/2, height/2);
      break;
  
   }
} 
void drawLife() {
    fill(230, 74, 96);
    textSize(16);
    text("LIFE :", 36, 448); 
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
      start=false;
   }
   if(pLife==0){
      status = GAME_LOSE;
   }
}

void checkWin(){
   if(brickNum==bricks.length){
      status = GAME_WIN;
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
  pLife=3;
  brickNum=0;
  start=false;
}
/*void mouseClicked(){
     if(mouseButton==RIGHT){
         status = GAME_PLAYING;
     }
}*/
void mouseClicked(){
  if(mouseButton==RIGHT && start==false && status==GAME_START){
    status = GAME_PLAYING;
    start=true;
    ball.xSpeed=random(-6,8);
    ball.ySpeed=-6;
    }
  } 

void keyPressed(){
    if(key == ENTER){
        switch(status) {  
           case GAME_START:
           status = GAME_PLAYING;
           start=true;
    ball.xSpeed=random(-4,7);
    ball.ySpeed=-6;
           break;
           
           case GAME_WIN:
           status = GAME_START;
           reset();
           break;
           
           case GAME_LOSE:
           status = GAME_START;
           reset();
           break;
       } 
     }
}
