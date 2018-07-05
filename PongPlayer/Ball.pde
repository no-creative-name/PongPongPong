class Ball {
  
  int diameter, hits, id, soundId;
  PVector position;
  PVector speed;
  float influenceX, spring, colorValue, mouseCurrentX;
  boolean isDead;
  
  Ball(PVector p, PVector s, int _ballDiameter, float _influenceX, int _id) {
    position = p;
    speed = s;
    diameter = _ballDiameter;
    influenceX = _influenceX;
    spring = 0.01;
    id = _id;
    colorValue = 255;
  }
  
  void run(boolean isCollidingWithPaddle, ArrayList<Ball> allBalls, boolean isPaddleInverted) {
    if(isPaddleInverted) {
      mouseCurrentX = -mouseX + width;
    }
    else {
      mouseCurrentX = mouseX;
    }
    if(speed.y <= 0) {
      speed.y += 0.3;
    }
    if(speed.y > 0) {
      speed.y += 0.25;
    }
    if(isCollidingWithPaddle) {
      soundId = 1;
      colorValue = random(200,255);
      hits++;
      float speedXY = sqrt(pow(speed.x, 2)+pow(speed.y, 2))+1;
      float posBallPaddleContactX = (position.x - mouseCurrentX)/(paddleWidth/2);
      speed.x = speedXY*posBallPaddleContactX*influenceX;
      speed.y = sqrt(pow(speedXY, 2)-pow(speed.x, 2)) * (speed.y > 0 ? -1 : 1);
    }
    else {
      soundId = 0;
    }
    
    if(doesBallHitSideWall()) {
       speed.x = -speed.x;
    }
    if(doesBallHitTopWall()) {
       speed.y = -speed.y;
       position.y = position.y + 1;
    }  
    if(speed.x > 20) {
      speed.x = 20;
    }
    if(speed.y > 20) {
      speed.y = 20;
    }
    if(doesBallFallDown()) {
      isDead = true;
    }
    for(int i = 0; i < allBalls.size(); i++) {
      if(i != id) {
        this.collide(allBalls.get(i));
      }
    }
    position.x = position.x + speed.x;
    position.y = position.y + speed.y;
    
    fill(colorValue);
    ellipse(position.x, position.y, diameter, diameter);
  }
  
  boolean doesBallHitPaddle(float paddleWidth, float paddleY) {
    return position.x > mouseCurrentX - paddleWidth / 2 && position.x < mouseCurrentX + paddleWidth / 2 && position.y > paddleY - paddleHeight / 2 - diameter / 2 && position.y < height;
  }
  
  boolean doesBallHitSideWall() {
    return position.x < 0 + diameter / 2 || position.x > width - diameter / 2;
  }
  
  boolean doesBallHitTopWall() {
    return position.y < 0 + diameter / 2;
  }  
  
  boolean doesBallFallDown() {
    return position.y > height + diameter / 2;
  }
  
  void collide(Ball secondBall) {
    
    float distanceX = secondBall.position.x - position.x;
    float distanceY = secondBall.position.y - position.y;
    float distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
    float minDist = secondBall.diameter/2 + diameter/2;
    
    if (distance <= minDist) {
      float angle = atan2(distanceY, distanceX);
      float targetX = position.x + cos(angle) * minDist;
      float targetY = position.y + sin(angle) * minDist;
      float ax = (targetX - secondBall.position.x) * spring;
      float ay = (targetY - secondBall.position.y) * spring;
      speed.x -= ax;
      speed.y -= ay;
      secondBall.speed.x += ax;
      secondBall.speed.y += ay;
      soundId = 2;
    }
  }
  
  void boost() {
    if(doesBallHitPaddle(paddleWidth, paddleY)) {
      speed.x *= 1.2;
      speed.y *= 1.2;
    }
  }
  
  void deboost() {
    if(doesBallHitPaddle(paddleWidth, paddleY)) {
      speed.x /= 1.2;
      speed.y /= 1.2;
    }
  }
}
