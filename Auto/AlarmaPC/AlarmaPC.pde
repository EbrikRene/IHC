import oscP5.*;
import netP5.*;
import P5ireBase.library.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;
float proximity;
String touch;
double longitude, latitude, altitude;
String botonpanico="false";
P5ireBase fire;

void setup() {
  size(480, 480);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.0.9", 12000); 
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textAlign(CENTER, CENTER);
  textSize(30);
  frameRate(2);
  fire = new P5ireBase(this, "https://ebrik-alarma-auto.firebaseio.com/");
}

void draw() {
  background(78, 93, 75);
  text("Remote Accelerometer Info: " + "\n" +
    "touch: "+ touch + "\n" +
    "x: "+ nfp(accelerometerX, 1, 3) + "\n" +
    "y: "+ nfp(accelerometerY, 1, 3) + "\n" +
    "z: "+ nfp(accelerometerZ, 1, 3) + "\n" +
    "longitude: "+ longitude + "\n" +
    "latitude: "+ latitude + "\n" +
    "altitude: "+ altitude + "\n" +
    "proximity: "+ proximity + "\n", width/2, height/2);
    
//    println(botonpanico);
//    if (fire.getValue("panico") != botonpanico){ 
 //       botonpanico = fire.getValue("panico"); 
 //       if (botonpanico == "true") {
 //         OscMessage myMessage = new OscMessage("panico");
  //        myMessage.add(int(1));
  //        oscP5.send(myMessage, remoteLocation);
 //       }
  //      else {
  //        OscMessage myMessage = new OscMessage("panico");
  //        myMessage.add(int(0));
   //       oscP5.send(myMessage, remoteLocation);
        }
 //     }
//}

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
  if (theOscMessage.checkTypetag("s"))   {
    touch =  theOscMessage.get(0).stringValue();  
    if (fire.getValue("touch") == "OK") {
      fire.setValue("touch", "ROTO");
    }
    else
      fire.setValue("touch", "OK");
  }
  if (theOscMessage.checkTypetag("i"))   {
    proximity =  theOscMessage.get(0).intValue();  
    fire.setValue("proximidad", str(proximity));
  }
  if (theOscMessage.checkTypetag("ii"))   {
    longitude =  theOscMessage.get(0).doubleValue();  
    latitude =  theOscMessage.get(1).doubleValue();
    altitude =  theOscMessage.get(2).doubleValue();
    fire.setValue("longitud", String.valueOf(longitude));
    fire.setValue("latitud", String.valueOf(latitude));
    fire.setValue("altitud", String.valueOf(altitude));
  }
}
