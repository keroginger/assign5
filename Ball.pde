class Ball{
  float x;
  float y;
  float xSpeed;
  float ySpeed;
  float size;
  
  void move(){
    x+=xSpeed;
    y+=ySpeed;
    
    if (x<size/2 || x>width-size/2){
      xSpeed *= -1;
    }
    if (y<size/2){
      ySpeed *= -1;
    }
    
    float bottom = y+size/2-5;
    float bl = board.y - 10/2;
    float bLeft = board.x-board.len/2;
    float bRight = board.x+board.len/2;
    if (bottom >= bl && x>bLeft && x<bRight){
        ySpeed *= -1;
        y = bl;
    }
  }
  void display(){
    fill(255);
    ellipse(x,y,size,size);
  }
  Ball(int ballX, int ballY){
    x= ballX;
    y = ballY;
    xSpeed = 5;
    ySpeed = 3;
    size = 10;
  }
}
