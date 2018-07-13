import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress godComputerLocation;

ArrayList<Player> players = new ArrayList<Player>();

void setup() {
  size(300,300);
  oscP5 = new OscP5(this, 12000);
  godComputerLocation = new NetAddress("192.168.0.104", 12000);
}

void oscEvent(OscMessage oscMessage) {
  if(oscMessage.checkAddrPattern("/playerLogin")) {
    sendPlayerCountToCsound();
    registerPlayer(oscMessage.get(0).stringValue(), oscMessage.get(1).intValue());
  }
  if(oscMessage.checkAddrPattern("/playerLogout")) {
    sendPlayerCountToCsound();
    unregisterPlayer(oscMessage.get(0).stringValue());  
  }
  if(oscMessage.checkAddrPattern("/brickSend")) {
    if(players.size() > 0) {
      forwardBrickMessageToRandomPlayer(oscMessage, oscMessage.get(0).stringValue());
    }
  }
}

void draw() {
    background(0);
    textSize(20);
    for(int i = 0; i < players.size(); i++) {
      text(players.get(i).ipAddress, width/2, 50+20*i);
    }
}

void registerPlayer(String ipAddress, int port) {
    boolean isPlayerAlreadyRegistered = false;
    for(int i = 0; i < players.size(); i++) {
      if(players.get(i).ipAddress == ipAddress) {
        isPlayerAlreadyRegistered = true;
      }
    }
    if(!isPlayerAlreadyRegistered) {
      players.add(new Player(ipAddress, port));
      OscMessage myMessage = new OscMessage("/playerLogin");
      myMessage.add(ipAddress);
      oscP5.send(myMessage, godComputerLocation);
    }
}

void unregisterPlayer(String ipAddress) {
    for(int i = 0; i < players.size(); i++) {
      if(players.get(i).ipAddress.equals(ipAddress)) {
        players.remove(i);
        OscMessage myMessage = new OscMessage("/playerLogout");
        myMessage.add(ipAddress);
        oscP5.send(myMessage, godComputerLocation);
      }
    }
}

void forwardBrickMessageToRandomPlayer(OscMessage message, String originIpAddress) {
      int currentPlayerPort = 15000;
      String ipToSendTo = "";
      int randomLocation = int(random(0, players.size()-1));
      ArrayList<Player> freePlayers = new ArrayList<Player>();
      for(int i = 0; i < players.size(); i++) {
        if(!players.get(i).ipAddress.equals(originIpAddress)) {
          freePlayers.add(players.get(i));
        }
      }
      if(freePlayers.size() > 0) {
        ipToSendTo = freePlayers.get(randomLocation).ipAddress;
        NetAddress myRemoteLocation = new NetAddress(ipToSendTo, currentPlayerPort);
        oscP5.send(message, myRemoteLocation);
      }
}

void sendPlayerCountToCsound() {
    OscMessage soundMessage = new OscMessage("/pong");
    soundMessage.add(constrain(players.size(), 0, 4));
    oscP5.send(soundMessage, new NetAddress("192.168.0.100", 12666));
}

void resetServer() {
  for(int i = 0; i < players.size(); i++) {
    OscMessage myMessage = new OscMessage("/playerLogout");
    myMessage.add(players.get(0).ipAddress);
    oscP5.send(myMessage, godComputerLocation);
    players.remove(i);
  }
}

void keyPressed() {
  if(key == ENTER) {
    resetServer();
  }
}

class Player {

  String ipAddress;
  int port;

  Player(String _ipAddress, int _port) {
    ipAddress = _ipAddress;
    port = _port;
  }

}
