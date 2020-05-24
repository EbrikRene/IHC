package com.maps;

import androidx.annotation.NonNull;
import androidx.fragment.app.FragmentActivity;

import android.os.Bundle;


import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.Polyline;
import com.google.android.gms.maps.model.PolylineOptions;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.maps.directionhelpers.*;



import java.util.ArrayList;

public class MapsActivity extends FragmentActivity implements OnMapReadyCallback, TaskLoadedCallback {

    private GoogleMap mMap;
    private LatLng origin,destiny;

    Polyline currentPolyline;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);


    }


    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
        public void onMapReady(GoogleMap googleMap) {
        DatabaseReference myDBR = FirebaseDatabase.getInstance().getReference();
        myDBR.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                if (dataSnapshot.exists()) {
                    Double latini = Double.parseDouble(dataSnapshot.child("inicio").child("coordenadas").child("lat").getValue().toString());
                    Double lngini = Double.parseDouble(dataSnapshot.child("inicio").child("coordenadas").child("lng").getValue().toString());
                    origin = new LatLng(latini, lngini);
                    mMap.addMarker(new MarkerOptions().position(new LatLng(latini, lngini)).title("Mi Posición"));

                    Double latdes = Double.parseDouble(dataSnapshot.child("destino").child("coordenadas").child("lat").getValue().toString());
                    Double lngdes = Double.parseDouble(dataSnapshot.child("destino").child("coordenadas").child("lng").getValue().toString());
                    destiny = new LatLng(latdes, lngdes);
                    mMap.addMarker(new MarkerOptions().position(new LatLng(latdes, lngdes)).title("Destino"));

                    long count = dataSnapshot.child("paradas").child("coordenadas").getChildrenCount();
                    int cant = (int)count;
                    LatLng[] ways = new LatLng[cant] ;
                    for (int i = 0; i < cant; i++) {
                        String val = String.valueOf(i);
                        Double latpar = Double.parseDouble(dataSnapshot.child("paradas").child("coordenadas").child(val).child("lat").getValue().toString());
                        Double lngpar = Double.parseDouble(dataSnapshot.child("paradas").child("coordenadas").child(val).child("lng").getValue().toString());
                        LatLng paradas = new LatLng(latpar, lngpar);
                        ways[i] = paradas;
                        mMap.addMarker(new MarkerOptions().position(paradas).title(val));



                    }
                    String url = getUrl(origin, ways, destiny, "driving");
                    new FetchURL(MapsActivity.this).execute(url, "driving");
                }
            }
            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });




        mMap = googleMap;

        // Add a marker in Sydney and move the camera
       LatLng chihuahua = new LatLng(28.66, -106.07);
       //mMap.addMarker(new MarkerOptions().position(chihuahua).title("Marker in Chihuahua"));
        mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(chihuahua,10));




    }

    private String getUrl(LatLng origin, LatLng[] way, LatLng dest, String directionMode) {
        // Origin of route
        String str_origin = "origin=" + origin.latitude + "," + origin.longitude;
        //Waypoints
        String aux = "";
        for(int i=0;i<way.length;i++){
            aux = aux + "|" + way[i].latitude + "," + way[i].longitude;
        }
        String str_wayp = "waypoints=optimize:true" + aux;
        // Destination of route
        String str_dest = "destination=" + dest.latitude + "," + dest.longitude;
        // Mode
        String mode = "mode=" + directionMode;
        // Building the parameters to the web service
        String parameters = str_origin + "&" + str_dest + "&" + str_wayp + "&" + mode;
        // Output format
        String output = "json";
        // Building the url to the web service
        String url = "https://maps.googleapis.com/maps/api/directions/" + output + "?" + parameters + "&key=" + getString(R.string.google_maps_key);
        return url;
    }

    @Override
    public void onTaskDone(Object... values) {
        if (currentPolyline != null)
            currentPolyline.remove();
        currentPolyline = mMap.addPolyline((PolylineOptions) values[0] );
    }
}
