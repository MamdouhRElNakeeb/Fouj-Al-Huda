package com.peekssolutions.fogalhoda.activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.CardView;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.peekssolutions.fogalhoda.R;

import butterknife.BindView;
import butterknife.ButterKnife;

public class AboutUsActivity extends AppCompatActivity implements OnMapReadyCallback {
    private GoogleMap mMap;
    @BindView(R.id.background)
    ImageView iv_background ;
    @BindView(R.id.cv_website)
    CardView cv_website ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about_us);
        ButterKnife.bind(this);

        iv_background.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(iv_background.getContext())
                        .load(R.drawable.splash_bg)
                        .asBitmap()
                        .crossFade()
                        .centerCrop()
                        .override(iv_background.getWidth(),iv_background.getHeight())
                        .into(iv_background);
            }
        });

        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);

        openWebsite();

    }

    private void openWebsite() {
        cv_website.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent= new Intent(Intent.ACTION_VIEW, Uri.parse("http://foujalhuda.com"));
                startActivity(intent);

            }
        });
    }


    @Override
    public void onMapReady(GoogleMap googleMap)  {
      mMap = googleMap;
        Log.e("Tag","Map Ready");
        createMarker("مكتب فوج الهدى","",21.445332,39.856285);
        mMap.setBuildingsEnabled(true);
        mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(21.445332,39.856285),16));


    }

    public void createMarker(String title,String description,double lat,double lon){
        LatLng loc = new LatLng(lat,lon);
        MarkerOptions locationMarker=new MarkerOptions();
        locationMarker.position(loc)
                .title(title)
                .icon(BitmapDescriptorFactory.fromResource(R.mipmap.marker_ic))
                .snippet(description)
        ;
        Marker marker = mMap.addMarker(locationMarker);
        marker.showInfoWindow();

    }
}
