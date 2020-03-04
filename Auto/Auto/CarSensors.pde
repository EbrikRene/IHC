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
  long[] pattern = {500, 300}; 
  switch(event){ 
    case Eventos.PROXIMITY_EVENT:
      alerta = "POSIBLE INTRUSO HUSMEANDO";
      vibe.vibrate(pattern, -1);
      file.play();
      break;
    case Eventos.TOUCH_EVENT:
      alerta = "ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES";
      vibe.vibrate(pattern, -1);
      file.play();
      break;
    case Eventos.CAR_DISTURBANCE_EVENT:
      alerta = "PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS";
      vibe.vibrate(pattern, -1);
      file.play();
      break;
    case Eventos.INTRUDER_EVENT:
      alerta = "INTRUSO EN EL AUTO";
      vibe.vibrate(pattern, -1);
      file.play();
      break;
    case Eventos.GPS_EVENT:
      alerta = "EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO";
      vibe.vibrate(pattern, -1);
      file.play();
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
  if (touchIsStarted){
    eventInTheCar(Eventos.TOUCH_EVENT);
    //"ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES"
          background(255,0,0);
          text("ALARMA INTENTO ROBO", width/2, height/2);

  } else if(accelerometer.x > 3.00 && accelerometer.z > 2.00){
     eventInTheCar(Eventos.CAR_DISTURBANCE_EVENT);
        //"PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS"
          background(255,0,0);
          text("ALARMA IMPACTO", width/2, height/2);

  } else if (touchIsStarted && light > 80.0){
      eventInTheCar(Eventos.INTRUDER_EVENT);
      //"INTRUSO EN EL AUTO"
          background(255,0,0);
          text("ALARMA INTRUSO DENTRO", width/2, height/2);
  } else if(proximity >= 50){
    //alerta = "POSIBLE INTRUSO HUSMEANDO";
          background(255,0,0);
          text("ALARMA INTRUSO", width/2, height/2);
    eventInTheCar(Eventos.PROXIMITY_EVENT);
  } else if(latitude != 0 && longitude != 0 && altitude!=0 && accelerometer.x > 3.00 && accelerometer.z > 2.00){
    //"EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO"
          background(255,0,0);
          text("ALARMA MOVIMIENTO", width/2, height/2);
    eventInTheCar(Eventos.GPS_EVENT);

  }
}
