import oscP5.*;
import netP5.*;  // 1
OscP5 oscP5;
String myIPAddress;
String remoteAddress = "192.168.0.5";  // 2 Customize!

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
  if(event < 0 || event > 4) return;
  String alerta = ""; // Compiler cries otherwise
  switch(event){ 
    case Eventos.PROXIMITY_EVENT:
      alerta = "POSIBLE INTRUSO HUSMEANDO";
      break;
    case Eventos.TOUCH_EVENT:
      alerta = "ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES";
      break;
    case Eventos.CAR_DISTURBANCE_EVENT:
      alerta = "PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS";
      break;
    case Eventos.INTRUDER_EVENT:
      alerta = "INTRUSO EN EL AUTO";
      break;
    case Eventos.GPS_EVENT:
      alerta = "EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO";
      break;
  }
  
  if(!isWatching){
    println("Se ha levantado la siguiente alerta: " + alerta + "\n Pero no hay dispositivo que nos escuche.");
  }
  
  OscMessage m = new OscMessage("/alerta");
  m.add(alerta);
  //bt.broadcast(m.getBytes());
  
  println("Se ha levantado la siguiente alerta: " + alerta);
}
 
class Eventos{
  static final int PROXIMITY_EVENT = 0;
  static final int TOUCH_EVENT = 1;
  static final int CAR_DISTURBANCE_EVENT = 2;
  static final int INTRUDER_EVENT = 3;
  static final int GPS_EVENT = 4;
}
 
 
void testSensorEvent(){
  long[] pattern = {500, 300}; 
  if (touchIsStarted){
    eventInTheCar(Eventos.TOUCH_EVENT);
    //"ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES"
          background(255,0,0);
          text("ALARMA INTENTO ROBO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();

  } else if(accelerometer.x > 3.00 && accelerometer.z > 2.00){
     eventInTheCar(Eventos.CAR_DISTURBANCE_EVENT);
        //"PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS"
          background(255,0,0);
          text("ALARMA IMPACTO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();

  } else if (touchIsStarted && light > 80.0){
      eventInTheCar(Eventos.INTRUDER_EVENT);
      //"INTRUSO EN EL AUTO"
          background(255,0,0);
          text("ALARMA INTRUSO DENTRO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
          
  } else if(proximity >= 50){
    eventInTheCar(Eventos.PROXIMITY_EVENT);
    //alerta = "POSIBLE INTRUSO HUSMEANDO";
          background(255,0,0);
          text("ALARMA INTRUSO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();
    
  } else if(latitude != 0 && longitude != 0 && altitude!=0 && accelerometer.x > 3.00 && accelerometer.z > 2.00){
    eventInTheCar(Eventos.GPS_EVENT);
    //"EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO"
          background(255,0,0);
          text("ALARMA MOVIMIENTO", width/2, height/2);
          vibe.vibrate(pattern, -1);
          file.play();

  }
}
void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);  // 9
  remoteLocation = new NetAddress(remoteAddress, 12000);  // 10
  myIPAddress = KetaiNet.getIP();    // 11
}
