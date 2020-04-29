var geocoder;
var geocoder2;
var nameMarcadores=[];
var paradasDir = [];
var paradasCoor = [];



dbinicio = firebase.database().ref('inicio');
dbdestino = firebase.database().ref('destino');
dbparadas = firebase.database().ref('paradas');

function start() {
	

	var autocomplete = new google.maps.places.Autocomplete(document.getElementById('end'));
	
    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer;
	geocoder = new google.maps.Geocoder();
	geocoder2 = new google.maps.Geocoder();
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 12,
        center: {
            lat: 28.66,
            lng: -106.07
        }
    });
    directionsDisplay.setMap(map);

    document.getElementById('route').addEventListener('click', function() {
        calculateAndDisplayRoute(directionsService, directionsDisplay);
		
		var geocoder3 = new google.maps.Geocoder();
		var address = document.getElementById('end').value;
		  geocoder3.geocode({ 'address': address}, function(results, status){
			if (results[0]){
				var lat = results[0].geometry.location.lat();
				var lng = results[0].geometry.location.lng();
				var pos1 = {lat, lng};
				dbdestino.set({direccion: address, coordenadas: pos1});
			}
		  });
			
	   var geocoder4 = new google.maps.Geocoder();
	    for (var i = 0; i < paradasDir.length; i++) {
             var addressx = paradasDir[i]; 
		     geocoder4.geocode({ 'address': addressx}, function(results, status){
			 if (results[0]){
				var lat = results[0].geometry.location.lat();
				var lng = results[0].geometry.location.lng();
				var pos2 = {lat, lng};
				paradasCoor.push(pos2);		
                dbparadas.set({direccion: paradasDir, coordenadas: paradasCoor});				
			}
		  });		  
	   }
	   
	   
		
		
    });
	
	document.getElementById('empty').addEventListener('click', function() {
		   dbdestino.set(null);
		   dbparadas.set(null);
		   dbinicio.set(null);
    });
	
	map.addListener('click', function(event) {
                placeMarker(event.latLng, map);
            });

            var marker;
            function placeMarker(location, map) {
                    marker = new google.maps.Marker({ //on créé le marqueur
                        position: location, 
                        map: map
                    });
				map.panTo(location);
				document.getElementById('lat').value=location.lat();
                document.getElementById('lng').value=location.lng();
                getAddress(location);
				
            }

      function getAddress(latLng) {
        geocoder.geocode( {'latLng': latLng},
          function(results, status) {
            if(status == google.maps.GeocoderStatus.OK) {
              if(results[0]) {
                 document.getElementById('ini').value = results[0].formatted_address;
				 nameMarcadores.push(document.getElementById('ini').value);
              }
              else {
                document.getElementById('ini').value = "No results";
              }
            }
            else {
              document.getElementById('ini').value = status;
            }
          });
        }
    
	
	var infoWindow = new google.maps.InfoWindow({map: map});
	// HTML5 geolocation.
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
        var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
        };
		
        geocoder2.geocode( {'latLng': pos},
          function(results, status) {
            if(status == google.maps.GeocoderStatus.OK) {
              if(results[0]) {
                 document.getElementById('start').value = results[0].formatted_address;
				 dbinicio.set({direccion: document.getElementById('start').value, coordenadas: pos})
              }
              else {
                document.getElementById('start').value = "No results";
              }
            }
            else {
              document.getElementById('start').value = status;
            }
          });
		
       infoWindow.setPosition(pos);
       infoWindow.setContent('Mi Posición!!!');
       map.setCenter(pos);
	   
       }, function() {
       handleLocationError(true, infoWindow, map.getCenter());
       });
       } else {
       // Si el navegador no soporta Geolocation
       handleLocationError(false, infoWindow, map.getCenter());
       }
	
	  
	
	
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
     infoWindow.setPosition(pos);
     infoWindow.setContent(browserHasGeolocation ?
     'Error: Servicio de Geolocation falló.' :
     'Error: Tu navegador no soporta Geolocation.');
}

function calculateAndDisplayRoute(directionsService, directionsDisplay) {
    var waypts = [];
	for(var i=0;i<nameMarcadores.length;i++){
		if (nameMarcadores[i]) {
	        waypts.push({
                 location: nameMarcadores[i],
                 stopover: true
            });
	        paradasDir.push(nameMarcadores[i]);
		}
	}
    var checkboxArray = document.getElementById('waypoints').getElementsByTagName('input');
    for (var i = 0; i < checkboxArray.length; i++) {
        if (checkboxArray[i].checked) {
            waypts.push({
                location: checkboxArray[i].value,
                stopover: true
            });
			paradasDir.push(checkboxArray[i].value);
        }
    }

	
    directionsService.route({
        origin: document.getElementById('start').value,
        destination: document.getElementById('end').value,
        waypoints: waypts,
        optimizeWaypoints: true,
        travelMode: google.maps.TravelMode.DRIVING
    }, function(response, status) {
        if (status === google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
            var route = response.routes[0];
            var summaryPanel = document.getElementById('directions-panel');
            summaryPanel.innerHTML = '';
            var totalDurationMin = 0;
            var totalDistanceMiles = 0;
            // For each route, display summary information.
            for (var i = 0; i < route.legs.length; i++) {
                totalDurationMin += route.legs[i].duration.value / 60; //  minutos
                totalDistanceMiles += route.legs[i].distance.value / 1000; //  kms
                var routeSegment = i + 1;
                summaryPanel.innerHTML += route.legs[i].duration.text + ': <b>Segmento Ruta: ' + routeSegment + '</b><br>'+
                '<b> Desde: </b>';
				summaryPanel.innerHTML += route.legs[i].start_address + '<b> hasta </b>';
                summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
                summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
            }
            var totals = document.getElementById('totals');
            totals.innerHTML = '<p><strong>Total de Kms:</strong> ' + (Math.round(totalDistanceMiles * 10) / 10) + ' km <strong>Tiempo Total de Viaje:</strong> ' + (Math.round(totalDurationMin * 100) / 100) + ' min</p>';
        } else {
            window.alert('Solicitud de direcciones fallida debido a ' + status);
        }
    });
}