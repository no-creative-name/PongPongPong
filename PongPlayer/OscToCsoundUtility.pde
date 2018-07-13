class OscToCsoundUtility {
  
  NetAddress csound;
  
  OscToCsoundUtility() {
    csound = new NetAddress("192.168.0.104", 16000);
  }
  
  void sendGameOver() {
    OscMessage myMessage = new OscMessage("/csound");
    myMessage.add(0);
    myMessage.add(-1);
    myMessage.add(random(0,1000));
    oscP5.send(myMessage, csound);
  }
  
  void sendNextLevel() {
    OscMessage myMessage = new OscMessage("/csound");
    myMessage.add(1);
    myMessage.add(-1);
    myMessage.add(random(0,1000));
    oscP5.send(myMessage, csound);
  }
  
  void sendPaddleCollision() {
    OscMessage myMessage = new OscMessage("/csound");
    myMessage.add(2);
    myMessage.add(-1);
    myMessage.add(random(0,1000));
    oscP5.send(myMessage, csound);
  }
  
  void sendBrickCollision(int id) {
    OscMessage myMessage = new OscMessage("/csound");
    myMessage.add(3);
    myMessage.add(id);
    myMessage.add(random(0,1000));
    oscP5.send(myMessage, csound);
  }
  
}
