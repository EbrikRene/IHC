valoraccelerometerx = 0;
valoraccelerometery = 0;
valoraccelerometerz = 0;
valorlatitud = -106.1433023;
valorlongitud = 28.6958111;
valoraltitud = 1534.0;
valortouch = "OK";
valorproximidad = 8;

//creamos una referencia a la base de datos para enviar el valor de la pagina en que nos encontramos
//dbluz = firebase.database().ref("home/sensores").child("sensorLuz");
dblongitud = firebase.database().ref("longitud");
dblatitud = firebase.database().ref("latitud");
dbaltitud = firebase.database().ref("altitud");
dbacelerometrox = firebase.database().ref("acelerometrox");
dbacelerometroy = firebase.database().ref("acelerometroy");
dbacelerometroz = firebase.database().ref("acelerometroz");
dbtouch = firebase.database().ref("touch");
dbproximidad = firebase.database().ref("proximidad");

dbemergencia = firebase.database().ref('emergencia');

$("#emergencia").click(function(){
    var estado = $(this).is(':checked');
    dbemergencia.update({
        emergencia:estado,
    });
});


dblongitud.on('value', function(snap){
  longitud.innerText = snap.val()
  valorlongitud = snap.val(); 
  console.log(longitud)
  cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad);
});

dblatitud.on('value', function(snap){
  latitud.innerText = snap.val() 
  valorlatitud = snap.val(); 
  console.log(latitud)
  cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad);
});

dbaltitud.on('value', function(snap){
  altitud.innerText = snap.val() 
  valoraltitud = snap.val(); 
  console.log(altitud)
  cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad);
});

dbproximidad.on('value', function(snap){
  proximidad.innerText = snap.val()
  valorproximidad = snap.val();
  console.log(proximidad)
  cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad);
});

dbacelerometrox.on('value', function(snap){
  acelerometrox.innerText = snap.val()
  valoraccelerometerx = snap.val();
  console.log(acelerometrox)
  cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad)
});

dbacelerometroy.on('value', function(snap){
  acelerometroy.innerText = snap.val()
  valoraccelerometery = snap.val();
  console.log(acelerometroy)
});

dbacelerometroz.on('value', function(snap){
  acelerometroz.innerText = snap.val()
  valoraccelerometerz = snap.val();
  console.log(acelerometroz)
  cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad)
});

dbtouch.on('value', function(snap){
  touch.innerText = snap.val()
  valortouch = snap.val();
  console.log(touch)
  cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad)
});

function cambiarImagen(valoraccelerometerx, valoraccelerometerz, valortouch, valorlatitud, valorlongitud, valoraltitud, valorproximidad){
        if(valoraccelerometerx > 3 && valoraccelerometerz > 9){
            console.log("CHOQUE DEL AUTO");
            $("#imgChoque").siblings().fadeOut(1000);
            $("#imgChoque").fadeIn(1000);
            $("#texto").text("CHOQUE DEL AUTO");
        }
        else if (valortouch == "ROTO"){
			console.log("VIDRIO ROTO");
            $("#imgVidrioRoto").siblings().fadeOut(1000);
			var audio = document.getElementById("audioVidrioRoto");
            audio.play()
            $("#imgVidrioRoto").fadeIn(1000)
            $("#texto").text("VIDRIO ROTO");
        }
        else if (valorlatitud != -106.1433023 && valorlongitud != 28.6958111 && valoraltitud!=1534.0){
          console.log("ROBO");
		  $("#imgRobo").siblings().fadeOut(1000);
          $("#imgRobo").fadeIn(1000)
          $("#texto").text("ROBO");
        }
        else if (valorproximidad > 0){
          console.log("INTRUSO HUSMEANDO");
		  $("#imgIntruso").siblings().fadeOut(1000);
          $("#imgIntruso").fadeIn(1000)
          $("#texto").text("INTRUSO HUSMEANDO");
        }
        else {
          console.log("AUTO OK");
		  $("#imgCarroOK").siblings().fadeOut(1000);
          $("#imgCarroOK").fadeIn(1000)
          $("#texto").text("AUTO OK");
        }
      }

