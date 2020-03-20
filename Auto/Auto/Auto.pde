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
SoundFile file2;
KetaiVibrate vibe;
OscP5 oscP5;
PVector accelerometer;
KetaiSensor sensor;
NetAddress remoteLocation;
float proximity;
float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
KetaiLocation location; 
double longitude, latitude, altitude;
KetaiList connectionList;  
String info = "";  
boolean isConfiguring = true;
String UIText;
String myIPAddress;
String remoteAddress = "192.168.0.6";  
ArrayList<String> devices = new ArrayList<String>();
boolean isWatching = false;
int emergencia = 0;


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
  file2 = new SoundFile(this, "alarma2.mp3");
  sensor = new KetaiSensor(this);
  location = new KetaiLocation(this);
  sensor.start();
  sensor.list();
}

void draw()
{
  if (touchIsStarted){
        OscMessage m1 = new OscMessage("touchData");
        m1.add("touch");
        oscP5.send(m1, remoteLocation);
  }
  
  OscMessage m2 = new OscMessage("accelerometerData"); 
  m2.add(myAccelerometerX);                        
  m2.add(myAccelerometerY);
  m2.add(myAccelerometerZ);
  oscP5.send(m2, remoteLocation);                  
  
  OscMessage m3 = new OscMessage("proximityData"); 
  m3.add(int(proximity));
  oscP5.send(m3, remoteLocation);
  
  OscMessage m4 = new OscMessage("gpsData"); 
  m4.add(longitude);                        
  m4.add(latitude);
  m4.add(altitude);
  oscP5.send(m4, remoteLocation); 
  
  if (emergencia == 1) {
      file.stop();
      file2.play();
      background(0,255,0);
      text("ALARMA", width/2, height/3);
      text("EMERGENCIA", width/2, height/2);
  }
  
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("i"))             
  {
    emergencia =  theOscMessage.get(0).intValue();              
  }
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);  
  remoteLocation = new NetAddress(remoteAddress, 12000);  
  myIPAddress = KetaiNet.getIP();    
}

void onAccelerometerEvent(float x, float y, float z){
  accelerometer.set(x, y, z);
  myAccelerometerX = x;
  myAccelerometerY = y;
  myAccelerometerZ = z;
  testSensorEvent();
}
  
void onProximityEvent(float v) {
  proximity = v;
  testSensorEvent();
 }
 
void onLocationEvent(double _latitude, double _longitude, double _altitude) {
  longitude = _latitude;
  latitude = _longitude;
  altitude = _altitude;
  testSensorEvent();
}
 
void eventInTheCar(int event){
  if(event < 0 || event > 4) return;
  String alerta = "";
  switch(event){ 
    case Eventos.PROXIMITY_EVENT:
      alerta = "INTRUSO HUSMEANDO";
      break;
    case Eventos.TOUCH_EVENT:
      alerta = "VIDRIO ROTO";
      break;
    case Eventos.ACCELEROMETER_EVENT:
      alerta = "CHOQUE DEL AUTO";
      break;
    case Eventos.GPS_EVENT:
      alerta = "ROBO";
      break;
  }
  
  if(!isWatching){
    println("Se ha levantado la siguiente alerta: " + alerta);
  }
  
  OscMessage m = new OscMessage("/alerta");
  m.add(alerta);
  
  println("Se ha levantado la siguiente alerta: " + alerta);
}
 
class Eventos{
  static final int PROXIMITY_EVENT = 0;
  static final int TOUCH_EVENT = 1;
  static final int ACCELEROMETER_EVENT = 2;
  static final int GPS_EVENT = 3;
}
 
void testSensorEvent(){
  long[] pattern = {500, 300}; 
  double la = -106.1433023;
  double lo = 28.6958111;
  double al = 1534.0;
  if (touchIsStarted){
    eventInTheCar(Eventos.TOUCH_EVENT);
    //"ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES"
          background(255,0,0);
          text("ALARMA", width/2, height/3);
          text("VIDRIO ROTO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();

  } else if(accelerometer.x > 3.00 && accelerometer.z > 9.00){
     eventInTheCar(Eventos.ACCELEROMETER_EVENT);
        //"PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS"
          background(255,0,0);
          text("ALARMA", width/2, height/3);
          text("CHOQUE DEL AUTO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
          
  } else if(proximity > 8){
    eventInTheCar(Eventos.PROXIMITY_EVENT);
    //alerta = "POSIBLE INTRUSO HUSMEANDO";
          background(0,0,255);
          text("ALARMA", width/2, height/3);
          text("INTRUSO HUSMEANDO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
          
  } else if(latitude != la && longitude != lo && altitude!=al){
    eventInTheCar(Eventos.GPS_EVENT);
    //"EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO"
          background(255,0,0);
          text("ALARMA", width/2, height/3);
          text("ROBO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
  }
}
