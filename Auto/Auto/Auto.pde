import oscP5.*;
import netP5.*;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import oscP5.*;
import ketai.camera.*;
import ketai.sensors.*;
import processing.sound.*;
import cassette.audiofiles.SoundFile;

SoundFile file;
KetaiVibrate vibe;
OscP5 oscP5;
PVector accelerometer;
KetaiSensor sensor;
NetAddress remoteLocation;
float light, proximity;
float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
KetaiLocation location; // 1
double longitude, latitude, altitude;
KetaiList connectionList;  // 4
String info = "";  // 5
boolean isConfiguring = true;
String UIText;
String myIPAddress;
String remoteAddress = "192.168.0.6";  // 2 Customize!
ArrayList<String> devices = new ArrayList<String>();
boolean isWatching = false;
int botonpanico = 0;


void setup()
{
  initNetworkConnection();
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  accelerometer = new PVector();
  vibe = new KetaiVibrate(this);
  file = new SoundFile(this, "alarma.mp3");
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  location = new KetaiLocation(this);
}

void draw()
{
}



void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);  // 9
  remoteLocation = new NetAddress(remoteAddress, 12000);  // 10
  myIPAddress = KetaiNet.getIP();    // 11
}

void onAccelerometerEvent(float x, float y, float z){
  accelerometer.set(x, y, z);
  testSensorEvent();
}
 
void onLightEvent(float v){
  light = v;
  testSensorEvent();
}
 
void onProximityEvent(float v) {
  proximity = v;
  testSensorEvent();
 }
 
void onLocationEvent(double _latitude, double _longitude, double _altitude) {
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  testSensorEvent();
}
 
void eventInTheCar(int event){
  if(event < 0 || event > 3) return;
  String alerta = ""; // Compiler cries otherwise
  switch(event){ 
    case Eventos.PROXIMITY_EVENT:
      alerta = "INTRUSO HUSMEANDO";
      break;
    case Eventos.TOUCH_EVENT:
      alerta = "VIDRIO ROTO";
      break;
    case Eventos.CAR_DISTURBANCE_EVENT:
      alerta = "CHOQUE DEL AUTO";
      break;
    case Eventos.GPS_EVENT:
      alerta = "ROBO";
      break;
  }
  
  if(!isWatching){
    println("Se ha levantado la siguiente alerta: " + alerta + "\n Pero no hay dispositivo que nos escuche.");
  }
  
  OscMessage m = new OscMessage("/alerta");
  m.add(alerta);
  
  println("Se ha levantado la siguiente alerta: " + alerta);
}
 
class Eventos{
  static final int PROXIMITY_EVENT = 0;
  static final int TOUCH_EVENT = 1;
  static final int CAR_DISTURBANCE_EVENT = 2;
  static final int GPS_EVENT = 3;
}
 
void testSensorEvent(){
  long[] pattern = {500, 300}; 
  if (touchIsStarted){
    eventInTheCar(Eventos.TOUCH_EVENT);
    //"ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES"
          background(255,0,0);
          text("ALARMA", width/2, height/3);
          text("VIDRIO ROTO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();

  } else if(accelerometer.x > 3.00 && accelerometer.z > 9.00){
     eventInTheCar(Eventos.CAR_DISTURBANCE_EVENT);
        //"PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS"
          background(255,0,0);
          text("ALARMA", width/2, height/3);
          text("CHOQUE DEL AUTO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
          
  } else if(proximity == 0){
    eventInTheCar(Eventos.PROXIMITY_EVENT);
    //alerta = "POSIBLE INTRUSO HUSMEANDO";
          background(255,0,0);
          text("ALARMA", width/2, height/3);
          text("INTRUSO HUSMEANDO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
          
  } else if(latitude != 0 && longitude != 0 && altitude!=0 && accelerometer.x > 3.00 && accelerometer.z > 9.00){
    eventInTheCar(Eventos.GPS_EVENT);
    //"EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO"
          background(255,0,0);
          text("ALARMA", width/2, height/3);
          text("ROBO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
  }
}
