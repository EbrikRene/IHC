import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;
String mensaje, alarma="";
void setup() {
  size(480, 480);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.0.13", 12000); // 1 Customize!
  textAlign(CENTER, CENTER);
  textSize(24);
}

void draw() {
  background(78, 93, 75);
  text("Remote Alarm Info: " + "\n" +
    "Alarma: "+ mensaje + "\n", width/2, height/2);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("s"))  // 6
  {
    mensaje =  theOscMessage.get(0).stringValue(); // 7
  }
}
