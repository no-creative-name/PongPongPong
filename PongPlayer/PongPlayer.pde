import oscP5.*;
import netP5.*;
import java.net.*;
import java.util.*;

OscP5 oscP5;
NetAddress server;
OscToCsoundUtility toCsound;

SceneFactory sceneFactory = new SceneFactory();
BrickFactory brickFactory = new BrickFactory();

ArrayList<Brick> brickLibrary = new ArrayList<Brick>();
ArrayList<Brick> bricks = new ArrayList<Brick>();
ArrayList<Brick> destroyedBricks = new ArrayList<Brick>();

ArrayList<Ball> balls = new ArrayList<Ball>();
ArrayList<Paddle> paddles = new ArrayList<Paddle>();

int currentLevel, paddleHeight, paddleX, paddleY, ballDiameter, initialNumberOfBalls, totalHits, soundId, playerPort, blackscreenStartTime;
float paddleWidth, initialBallSpeedX, initialBallSpeedY, initialBallX, initialBallY, ballInfluenceX;
boolean isGameOver, hasWon, isBoosting, isDeboosting, isRegistered, isToRestart, isPaddleInverted, isBlackscreen;
boolean pongPongPong;
String hostAddress;

int count = 0;

PFont font;
color backgroundColor;

void setup() {
  
  pongPongPong = true;
  //size(900, 800, P2D);
  fullScreen(P2D);
  noCursor();
  
  //pixelDensity(displayDensity());
  
  currentLevel = 0;
  paddleWidth = 200;
  paddleHeight = 10;
  paddleX = width / 2;
  paddleY = height - 20;
  initialNumberOfBalls = 1;
  ballDiameter = 30;
  initialBallX = 50;
  initialBallY = 50;
  initialBallSpeedX = 1;
  initialBallSpeedY = 5;
  ballInfluenceX = 0.2;
  isGameOver = false;
  hasWon = false;
  
  soundId = 0;
  
  initializeHostAddress(); //<>//
  
  playerPort = 15000;
  oscP5 = new OscP5(this, playerPort);
  server = new NetAddress("192.168.0.100", 12000);
  toCsound = new OscToCsoundUtility();
  
  bricks.clear();
  balls.clear();
  paddles.clear();
    
  initializeBrickLibrary();
     //<>//
  backgroundColor = sceneFactory.CreateScene1();
  font = loadFont("KarmaticArcade-48.vlw");
  
  //  Initialize balls
  for (int i = 0; i < initialNumberOfBalls; i++) {
    balls.add(new Ball(new PVector(initialBallX+(i*ballDiameter*2), initialBallY), new PVector(initialBallSpeedX*(random(2)+1), initialBallSpeedY*(random(2)+1)), ballDiameter, ballInfluenceX, i));
  }
  
  //  Initialize paddles
  paddles.add(new Paddle(paddleWidth, paddleHeight, paddleX, paddleY, 0));
  
  registerPlayer();
}

void draw() {
  
  textFont(font);
  
  //  Reset blackscreen after 2 seconds
  if(millis() - blackscreenStartTime > 2000) {
    isBlackscreen = false;
  }
  //  Slowly reset paddle to initial width
  for(int j = 0; j < paddles.size(); j++) {
      Paddle paddle = paddles.get(j);
      if(paddle.paddleWidth < this.paddleWidth) {
        paddle.paddleWidth += 0.5;
      }
  }
  
  background(backgroundColor);
    
  if (isToRestart) {
    background(0);
    textSize(50);
    if(count % 50 == 0) {
      fill(0);
    }
    if(count % 100 == 0) {
      fill(255);
    }
    text("PRESS SPACE TO JOIN GAME  ", width/2-500, height/2);
  }
  else if (isGameOver) {
    toCsound.sendGameOver();
    fill(255);
    textSize(50);
    text("GAME OVER", width/2-220, height/2);
    if(isRegistered) {
      isPaddleInverted = false;
      unregisterPlayer();
    }
    if(frameCount % 200 == 0) {
      isToRestart = true;
    }
  }
  else if(hasWon) {
    toCsound.sendNextLevel();
    int nextLevel = currentLevel + 1;
    print(nextLevel);
    if(nextLevel == 4) {
      nextLevel = 0;
    }
    setupNextLevel(nextLevel);
    currentLevel = nextLevel;
  }
  else {
    if(count % 100 == 0 && count != 0) {
      pongPongPong = false;
    }
    if(pongPongPong) {
      fill(255);
      textSize(100);
      text("PONG PONG PONG!", width/2-width/3.5, height/2);
    }
    collideBallWithBricks();
    collidePaddleWithBall();
    
    if(balls.size() == 0) {
      isGameOver=true;
    }
    
    if(bricks.size() <= 0) {
      hasWon = true;
    }
    
    fill(255);
    textSize(25);
    text("HITS: "+totalHits, 10, 50);
    
    if (isBlackscreen) {
      fill(0);
      rect(0,0,width,height);
    }
  }
  
  count++;
}

void oscEvent(OscMessage oscMessage) {
  if(oscMessage.checkAddrPattern("/brickSend")) {
    Brick brick = brickLibrary.get(oscMessage.get(2).intValue());
    boolean isBrickAlreadyExisting = false;
    for(int i = 0; i < bricks.size(); i++) {
      if(bricks.get(i).id == brick.id) {
        isBrickAlreadyExisting = true;
      }
    }
    if(!isBrickAlreadyExisting) {
      bricks.add(brick);
    }
  }
  else if(oscMessage.checkAddrPattern("/godAddBall")) {
    if(balls.size() < 3) {
      balls.add(new Ball(new PVector(initialBallX+(3*ballDiameter*2), initialBallY), new PVector(initialBallSpeedX*(random(2)+1), initialBallSpeedY*(random(2)+1)), ballDiameter, ballInfluenceX, 3));
    }
  }
  else if(oscMessage.checkAddrPattern("/godSpeedUpBall")) {
    for(int i = 0; i < balls.size(); i++) {
      Ball ball = balls.get(i);
      if(sqrt(pow(ball.speed.x, 2)+pow(ball.speed.y, 2))+1 < 30) {
        ball.speed.x *= 1.5;
        ball.speed.y *= 1.5;
      }
    }
  }
  else if(oscMessage.checkAddrPattern("/godInvertPaddle")) {
    if(isPaddleInverted) {
     isPaddleInverted = false;
    }
    else {
     isPaddleInverted = true;
    }
  }
  else if(oscMessage.checkAddrPattern("/godMakePaddleSmaller")) {
    for(int j = 0; j < paddles.size(); j++) {
        Paddle paddle = paddles.get(j);
        if(paddle.paddleWidth > 50) {
          paddle.paddleWidth /= 2;
        }
    }
  }
  else if(oscMessage.checkAddrPattern("/godBlackscreen")) {
    if(!isBlackscreen) {
       isBlackscreen = true;
       blackscreenStartTime = millis();
    }
  }    
}

void keyPressed() {
  if (key == ' ') {
    if(isRegistered) {
      unregisterPlayer();
    }
    isToRestart = false;
    setup();
  }
  else if (key == 27) {
    key = 0;
  }
  else if (key == 'q') {
    unregisterPlayer();
    exit();
  }
}

void mousePressed() {
  if(mouseButton == LEFT) {
    isBoosting = true;
  }
  if(mouseButton == RIGHT) {
    isDeboosting = true;
  }
}

void mouseReleased() {
  if(mouseButton == LEFT) {
    isBoosting = false;
  }
  if(mouseButton == RIGHT) {
    isDeboosting = false;
  }
}

void initializeHostAddress() {
  try {
    Enumeration<NetworkInterface> nets = NetworkInterface.getNetworkInterfaces();
    for (NetworkInterface netint : Collections.list(nets)) {
      if (netint.getName().equals("wlan0")) {
        Enumeration<InetAddress> inetAddresses = netint.getInetAddresses();
        ArrayList<InetAddress> iA = Collections.list(inetAddresses);
        if (Character.getNumericValue(iA.get(0).toString().substring(1).charAt(0)) == 1) {
          hostAddress = iA.get(0).toString().substring(1);
        }
        else {
          hostAddress = iA.get(1).toString().substring(1);
        }
      }
    }
  }
  catch (SocketException e) {
    
  }
}

void collideBallWithBricks() {
  IntList toRemove = new IntList();
  for(int i = 0; i < bricks.size(); i++) {
      Brick brick =  bricks.get(i);
      boolean brickHasAlreadyCollided = false;
      for(int j = 0; j < balls.size(); j++) {
        brick.run(balls.get(j));
        if (brick.isColliding && !brickHasAlreadyCollided) {
          totalHits++;
          
          //SEND BRICK DATA
          OscMessage message = new OscMessage("/brickSend");
          
          message.add(hostAddress);
          message.add(playerPort);
          
          message.add(brick.id);
          oscP5.send(message, server);
          
          toCsound.sendBrickCollision(brick.id);
          
          destroyedBricks.add(bricks.get(i));
          toRemove.append(i);
          brickHasAlreadyCollided = true;
        }
      }
    }
    for (int i = toRemove.size() - 1; i >= 0; i--) {
      bricks.remove(toRemove.get(i));
    }
}

void collidePaddleWithBall() {
  for(int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    if(!ball.isDead) {
      for(int j = 0; j < paddles.size(); j++) {
        Paddle paddle = paddles.get(j);
        paddle.run(ball, isBoosting, isDeboosting, isPaddleInverted);
        ball.run(paddle.isColliding, balls, isPaddleInverted);
        if(paddle.isColliding) {
          //toCsound.sendPaddleCollision();
        }
      };
     if(isBoosting) {
        ball.boost();
      }
      if(isDeboosting) {
        ball.deboost();
      } 
    }
    else {
      balls.remove(i);
    }
  }
}

void initializeBrickLibrary() {
  brickLibrary.add(brickFactory.CreateQuad(460, 550, 745, 550, 770, 600, 485, 600, 0, color(128, 128, 128, 240)));
  brickLibrary.add(brickFactory.CreateQuad(440, 250, 1200, 250, 1310, 430, 550, 430, 1, color(0, 0, 0, 240)));
  brickLibrary.add(brickFactory.CreateQuad(545, 450, 595, 450, 695, 630, 645, 630, 2, color(255, 255, 153, 150)));
  brickLibrary.add(brickFactory.CreateCircle(900, 250, 150, 3, color(255, 0, 0, 170)));
  brickLibrary.add(brickFactory.CreateCircle(650, 550, 75, 4, color(255, 0, 0, 170)));
  brickLibrary.add(brickFactory.CreateQuad(710, 100, 810, 100, 1050, 500, 940, 500, 5, color(255, 255, 0, 160)));
  brickLibrary.add(brickFactory.CreateQuad(590, 565, 700, 565, 635, 700, 525, 700, 6, color(0, 0, 0, 180)));
  brickLibrary.add(brickFactory.CreateQuad(700, 300, 1065, 300, 895, 660, 530, 660, 7, color(255, 255, 255, 160)));
  int s = 500;
  int o = 400;
  brickLibrary.add(brickFactory.CreateQuad(100+s, 30+o, 90+s, 20+o, 80+s, 30+o, 90+s, 40+o, 8, color(13, 86, 41, 240)));
  brickLibrary.add(brickFactory.CreateQuad(110+s, 20+o, 130+s, 10+o, 155+s, 50+o, 135+s, 60+o, 9, color(203, 38, 42, 240)));
  brickLibrary.add(brickFactory.CreateQuad(200+s, 50+o, 230+s, 60+o, 215+s, 130+o, 185+s, 120+o, 10, color(203, 38, 42, 240)));
  brickLibrary.add(brickFactory.CreateQuad(300+s, 0+o, 310+s, 0+o, 260+s, 250+o, 250+s, 250+o, 11, color(106, 69, 51, 240)));
  brickLibrary.add(brickFactory.CreateQuad(100+s, 260+o, 100+s, 190+o, 200+s, 180+o, 200+s, 260+o, 12, color(211, 184, 43, 240)));
  brickLibrary.add(brickFactory.CreateCircle(380+s,100+o,50, 13, color(196, 178, 50, 170)));
  brickLibrary.add(brickFactory.CreateQuad(450+s, 0+o, 470+s, 0+o, 560+s, 140+o, 540+s, 145+o, 14, color(46, 110, 58, 240)));
  brickLibrary.add(brickFactory.CreateQuad(790+s, 30+o, 785+s, 120+o, 680+s, 120+o, 680+s, 25+o, 15, color(203, 38, 42, 240)));
  brickLibrary.add(brickFactory.CreateQuad(785+s, 135+o, 780+s, 225+o, 680+s, 220+o, 685+s, 145+o, 16, color(205, 108, 40, 240)));
  brickLibrary.add(brickFactory.CreateQuad(450+s, 400+o, 400+s, 400+o, 560+s, 190+o, 650+s, 215+o, 17, color(0, 0, 0, 240)));
  brickLibrary.add(brickFactory.CreateQuad(510+s, 220+o, 540+s, 230+o, 530+s, 260+o, 500+s, 260+o, 18, color(80, 88, 109, 240)));    
  brickLibrary.add(brickFactory.CreateQuad(505+s, 240+o, 460+s, 230+o, 455+s, 255+o, 500+s, 265+o, 19, color(203, 38, 42, 240)));  
  brickLibrary.add(brickFactory.CreateQuad(535, 0, 620, 0, 940, 800, 850, 800, 20, color(255, 255, 255, 50)));
  brickLibrary.add(brickFactory.CreateQuad(500, 800, 1030, 560, 1045, 640, 700, 800, 21, color(160, 15, 15, 50)));
  brickLibrary.add(brickFactory.CreateCircle(860, 590, 150, 22, color(0, 0, 0, 0)));
  brickLibrary.add(brickFactory.CreateCircle(749, 430, 90, 23, color(198, 20, 14)));
  brickLibrary.add(brickFactory.CreateTriangle(550, 375, 630, 320, 710, 775, 24, color(0)));
  brickLibrary.add(brickFactory.CreateQuad(400, 410, 410, 410, 880, 600, 870, 600, 25, color(52, 142, 97)));
  brickLibrary.add(brickFactory.CreateQuad(620, 630, 870, 410, 880, 410, 630, 630, 26, color(52, 142, 97)));
  brickLibrary.add(brickFactory.CreateQuad(306, 775, 617, 265, 617, 269, 306, 781, 27, color(#403D5C)));
  brickLibrary.add(brickFactory.CreateQuad(422, 494, 622, 367, 622, 371, 422, 498, 28, color(#C7740A)));
  brickLibrary.add(brickFactory.CreateQuad(288, 766, 345, 803, 345, 807, 288, 770, 29, color(#AA2810)));
  brickLibrary.add(brickFactory.CreateQuad(427, 432, 480, 435, 480, 439, 427, 436, 30, color(#AA2810)));
  brickLibrary.add(brickFactory.CreateQuad(180, 482, 235, 460, 235, 464, 180, 486, 31, color(#AA2810)));
  brickLibrary.add(brickFactory.CreateQuad(43, 241, 133, 240, 133, 244, 43, 245, 32, color(#AA2810)));
  brickLibrary.add(brickFactory.CreateQuad(87, 294, 82, 217, 82, 221, 87, 298, 33, color(#AA2810)));
  brickLibrary.add(brickFactory.CreateQuad(71, 127, 210, 465, 210, 469, 71, 131, 34, color(#AA2810)));
  brickLibrary.add(brickFactory.CreateTriangle(310, 243, 403, 245, 372, 387, 35, color(#EB7201)));
  brickLibrary.add(brickFactory.CreateQuad(338, 371, 584, 436, 584, 440, 338, 375, 36, color(255, 255, 255, 160)));
  brickLibrary.add(brickFactory.CreateQuad(258, 779, 283, 786, 277, 816, 257, 812, 37, color(#10284E)));
  brickLibrary.add(brickFactory.CreateQuad(288, 638, 300, 638, 301, 648, 288, 650, 38, color(#403C77)));
  brickLibrary.add(brickFactory.CreateQuad(365, 341, 455, 305, 467, 333, 371, 368, 39, color(0)));
  brickLibrary.add(brickFactory.CreateQuad(89, 400, 648, 188, 655, 206, 96, 417, 40, color(#BD1304)));
  brickLibrary.add(brickFactory.CreateQuad(540, 169, 568, 159, 609, 268, 582, 280, 41, color(#BD1304)));
  brickLibrary.add(brickFactory.CreateQuad(168, 249, 419, 244, 418, 177, 167, 209, 42, color(#AA0C01)));
  brickLibrary.add(brickFactory.CreateQuad(224, 202, 213, 130, 501, 91, 511, 165, 43, color(#101103)));
  brickLibrary.add(brickFactory.CreateQuad(314, 120, 305, 31, 397, 26, 406, 105, 44, color(#101103)));
  brickLibrary.add(brickFactory.CreateQuad(401, 79, 538, 59, 540, 89, 406, 107, 45, color(#CA3904)));
}

void setupNextLevel(int levelId) {
  paddleWidth = 200;
  paddleHeight = 10;
  paddleX = width / 2;
  paddleY = height - 20;
  initialNumberOfBalls = 1;
  ballDiameter = 30;
  initialBallX = 50;
  initialBallY = 50;
  initialBallSpeedX = 1;
  initialBallSpeedY = 5;
  ballInfluenceX = 0.2;
  isGameOver = false;
  hasWon = false;
  
  bricks.clear();
  //balls.clear();
  paddles.clear();
  switch(levelId) {
    case 0:
      backgroundColor = sceneFactory.CreateScene1();
      break;
    case 1:
      backgroundColor = sceneFactory.CreateScene2();
      break;
    case 2:
      backgroundColor = sceneFactory.CreateScene3();
      break;
    case 3:
      backgroundColor = sceneFactory.CreateScene4();
      break;
    case 4:
      backgroundColor = sceneFactory.CreateScene5();
      break;
  }
  
  //  Initialize balls
  /*for (int i = 0; i < initialNumberOfBalls; i++) {
    balls.add(new Ball(new PVector(initialBallX+(i*ballDiameter*2), initialBallY), new PVector(initialBallSpeedX*(random(2)+1), initialBallSpeedY*(random(2)+1)), ballDiameter, ballInfluenceX, i));
  }*/
  
  //  Initialize paddles
  paddles.add(new Paddle(paddleWidth, paddleHeight, paddleX, paddleY, 0));
  
  count = 0;
  pongPongPong = true;
}

void registerPlayer() {
  OscMessage myMessage = new OscMessage("/playerLogin");
  myMessage.add(hostAddress);
  myMessage.add(playerPort);
  oscP5.send(myMessage, server);
  isRegistered = true;
}

void unregisterPlayer() {
  OscMessage myMessage = new OscMessage("/playerLogout");
  myMessage.add(hostAddress);
  oscP5.send(myMessage, server);
  isRegistered = false;
}
