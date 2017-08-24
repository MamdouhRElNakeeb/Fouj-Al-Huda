package com.peekssolutions.fogalhoda.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.peekssolutions.fogalhoda.R;

import butterknife.BindView;
import butterknife.ButterKnife;

public class SplashActivity extends AppCompatActivity {

    private static final long SPLASH_TIME_OUT = 2000 ;
    @BindView(R.id.background)
    ImageView img_background ;
    @BindView(R.id.imageView)
    ImageView imageView ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
        ButterKnife.bind(this);
        /*
         *Going to Another Activity after time
         * @SPLASH_TIME_OUT
         */
        img_background.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(img_background.getContext())
                        .load(R.drawable.splash_bg)
                        .asBitmap()
                        .crossFade()
                        .centerCrop()
                        .override(img_background.getWidth(),img_background.getHeight())
                        .into(img_background);
            }
        });

        imageView.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(imageView.getContext())
                        .load(R.drawable.splash_logo)
                        .asBitmap()
                        .crossFade()
                        .override(imageView.getWidth(),imageView.getHeight())
                        .into(imageView);
            }
        });

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {

                startActivity(new Intent(SplashActivity.this, ChooseServiceActivity.class));
                finish();
            }
        },SPLASH_TIME_OUT);
    }
}
