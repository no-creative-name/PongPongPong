class OscToCsoundUtility {
  
  NetAddress csound;
  
  OscToCsoundUtility() {
    csound = new NetAddress("localhost", 16000);
  }
  
  void sendGameOver() {
    OscMessage myMessage = new OscMessage("/gameOver");
    oscP5.send(myMessage, csound);
  }
  
  void sendNextLevel() {
    OscMessage myMessage = new OscMessage("/nextLevel");
    oscP5.send(myMessage, csound);
  }
  
  void sendBrickCollision(int id) {
    OscMessage myMessage = new OscMessage("/brickCollision");
    myMessage.add(id);
    oscP5.send(myMessage, csound);
  }
  
  void sendPaddleCollision() {
    OscMessage myMessage = new OscMessage("/paddleCollision");
    oscP5.send(myMessage, csound);
  }
  
}
