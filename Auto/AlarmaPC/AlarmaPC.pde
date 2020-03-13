import oscP5.*;
import netP5.*;


NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;
String mensaje, alarma="";
boolean isWatching = false;

PVector accelerometer;
float light, proximity;
double longitude, latitude, altitude;

void setup() {
  size(480, 480);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.0.13", 12000); // 1 Customize!
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  accelerometer = new PVector();
}

void draw() {
 
}
