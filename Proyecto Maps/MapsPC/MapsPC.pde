import oscP5.*;
import netP5.*;
import P5ireBase.library.*;

OscP5 oscP5;
NetAddress remoteLocation;
String inicio;
P5ireBase fire;

void setup() {
  size(1300, 480);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.0.9", 12000); 
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textAlign(CENTER, CENTER);
  textSize(15);
  frameRate(2);
  fire = new P5ireBase(this, "https://maps-273521.firebaseio.com/");
}

void draw() {
  background(255, 0, 0);
  text("Información: " + "\n" +
    "Inicio: "+ fire.getValue("inicio") + "\n"+
    "Destino: "+ fire.getValue("destino") + "\n"+
    "Paradas: "+ fire.getValue("paradas") + "\n", width/2, height/2);
    
       // inicio = fire.getValue("inicio"); 
       // OscMessage myMessage = new OscMessage("inicio");
      //  myMessage.add(inicio);
     // oscP5.send(myMessage, remoteLocation);
    }
