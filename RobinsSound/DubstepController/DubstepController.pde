import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress csoundRemoteLocation;


boolean isBallChangeAllowed = true;

void setup() {
  
size(500,500);
background (255);
//framerate(30);

  oscP5 = new OscP5(this, 12665);
  csoundRemoteLocation = new NetAddress("localhost", 12666);


  
    }
        
void draw() {
  fill(222);
  rect(25, 25, 50, 50);
  

}
          
void mouseClicked() {
 
    print("asdad");
  
  OscMessage myMessage = new OscMessage("/pong");
  myMessage.add(1);
  oscP5.send(myMessage, csoundRemoteLocation);
}