import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation, godComputerLocation;

//ArrayList<Integer> playerPorts = new ArrayList<Integer>();
ArrayList<Player> players = new ArrayList<Player>();

int messageNumber;

void setup() {
  size(300,300);
  oscP5 = new OscP5(this, 12000);
  godComputerLocation = new NetAddress("192.168.0.104", 12000);
}

void oscEvent(OscMessage oscMessage) {
  if(oscMessage.checkAddrPattern("/playerSetup")) {
    OscMessage soundMessage = new OscMessage("/pong");
    soundMessage.add(constrain(players.size(), 0, 4));
    oscP5.send(soundMessage, new NetAddress("192.168.0.100", 12666));
    String currentPlayerIpAddress = oscMessage.get(0).stringValue();
    int currentPlayerPort = oscMessage.get(1).intValue();
    boolean isPlayerAlreadyRegistered = false;
    for(int i = 0; i < players.size(); i++) {
      if(players.get(i).ipAddress == currentPlayerIpAddress) {
        isPlayerAlreadyRegistered = true;
      }
    }
    if(!isPlayerAlreadyRegistered) {
      players.add(new Player(currentPlayerIpAddress, currentPlayerPort));
      OscMessage myMessage = new OscMessage("/playerLogin");
      myMessage.add(currentPlayerIpAddress);
      oscP5.send(myMessage, godComputerLocation);
      print("send");
    }
  }
  if(oscMessage.checkAddrPattern("/brickSend")) {
    if(players.size() > 0) {
      String currentPlayerIpAddress = oscMessage.get(0).stringValue();
      int currentPlayerPort = oscMessage.get(1).intValue();
      String ipToSendTo = "";
      int randomLocation = int(random(0, players.size()-1));
      ArrayList<Player> freePlayers = new ArrayList<Player>();
      for(int i = 0; i < players.size(); i++) {
        if(!players.get(i).ipAddress.equals(currentPlayerIpAddress)) {
          freePlayers.add(players.get(i));
        }
      }
      if(freePlayers.size() > 0) {
        ipToSendTo = freePlayers.get(randomLocation).ipAddress;
        myRemoteLocation = new NetAddress(ipToSendTo, currentPlayerPort);
        oscP5.send(oscMessage, myRemoteLocation);
      }
    }
  }
  if(oscMessage.checkAddrPattern("/playerLogout")) {
    OscMessage soundMessage = new OscMessage("/pong");
    soundMessage.add(constrain(players.size()-1, 0, 4));
    oscP5.send(soundMessage, new NetAddress("localhost", 12666));
    String currentPlayerIpAddress = oscMessage.get(0).stringValue();
    for(int i = 0; i < players.size(); i++) {
      if(players.get(i).ipAddress.equals(currentPlayerIpAddress)) {
        players.remove(i);
        print(players.size());
        OscMessage myMessage = new OscMessage("/playerLogout");
        myMessage.add(currentPlayerIpAddress);
        oscP5.send(myMessage, godComputerLocation);
      }
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

class Player {

  String ipAddress;
  int port;

  Player(String _ipAddress, int _port) {
    ipAddress = _ipAddress;
    port = _port;
  }

}
