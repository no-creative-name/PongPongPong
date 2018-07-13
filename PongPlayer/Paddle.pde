class Paddle {
  
  float paddleWidth, paddleHeight, paddleX, paddleY, mouseCurrentX;
  int id;
  boolean isColliding;
  
  Paddle(float _paddleWidth, float _paddleHeight, float _paddleX, float _paddleY, int _id) {
    paddleWidth = _paddleWidth;
    paddleHeight = _paddleHeight;
    paddleX = _paddleX;
    paddleY = _paddleY;
    id = _id;
  }
  
  void run(Ball ball, boolean _isBoosting, boolean _isDeboosting, boolean _isPaddleInverted) {
    if(_isPaddleInverted) {  
      mouseCurrentX = -mouseX + width;
    }
    else {
      mouseCurrentX = mouseX;
    }
    if(ball.position.x > mouseCurrentX - paddleWidth / 2 && ball.position.x < mouseCurrentX + paddleWidth / 2 && ball.position.y > paddleY - paddleHeight / 2 - ball.diameter / 2  && ball.position.y < height) { //<>// //<>//
      isColliding = true; 
    }
    else {
      isColliding = false;
    }
    if(_isBoosting) {
      fill(255, 0, 0);
    }
    else if(_isDeboosting) {
      fill(0, 255, 0);
    }
    else {
      fill(255);
    }
    rect(mouseCurrentX - paddleWidth / 2, paddleY, paddleWidth, paddleHeight);
  }
}
