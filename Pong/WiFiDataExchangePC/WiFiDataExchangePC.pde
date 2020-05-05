import oscP5.*;
import netP5.*;
import P5ireBase.library.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;
P5ireBase fire;

void setup() {
  size(480, 480);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.0.11", 12000);  
  textAlign(CENTER, CENTER);
  textSize(24);
  fire = new P5ireBase(this, "https://pong-ebrik.firebaseio.com/");
}

void draw() {
  background(78, 93, 75);
  text("Remote Accelerometer Info: " + "\n" +
    "x: "+ nfp(accelerometerX, 1, 3) + "\n" +
    "y: "+ nfp(accelerometerY, 1, 3) + "\n" +
    "z: "+ nfp(accelerometerZ, 1, 3) + "\n\n" +
    "Local Info: \n" + 
    "mousePressed: " + mousePressed, width/2, height/2);

  OscMessage myMessage = new OscMessage("mouseStatus");
  myMessage.add(mouseX);                                  
  myMessage.add(mouseY);                                  
  myMessage.add(int(mousePressed));                       
  oscP5.send(myMessage, remoteLocation);                  
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("fff"))                  
  {
    accelerometerX =  theOscMessage.get(0).floatValue();  
    accelerometerY =  theOscMessage.get(1).floatValue();
    accelerometerZ =  theOscMessage.get(2).floatValue();
    fire.setValue("acelerometrox", str(accelerometerX));
    fire.setValue("acelerometroy", str(accelerometerY));
    fire.setValue("acelerometroz", str(accelerometerZ));
  }
}
