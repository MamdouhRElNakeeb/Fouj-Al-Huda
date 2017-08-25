package com.peekssolutions.fogalhoda.activity;

import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.AppCompatButton;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.androidnetworking.AndroidNetworking;
import com.androidnetworking.error.ANError;
import com.androidnetworking.interfaces.ParsedRequestListener;
import com.bumptech.glide.Glide;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.model.ServerResponse;
import com.peekssolutions.fogalhoda.utils.Url;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class RequestFatwaActivity extends AppCompatActivity {
    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    @BindView(R.id.btn_request_fatwa)
    AppCompatButton btn_request_fatwa ;
    TextView toolbar_title ;
    ImageView iv_background ;
    ImageView iv_logo ;
    ImageView iv_ic ;
    @BindView(R.id.et_fatwa)
    EditText et_fatwa ;
    @BindView(R.id.et_name)
    EditText et_name ;
    @BindView(R.id.et_email)
    EditText et_email ;
    @BindView(R.id.et_phone)
    EditText et_phone ;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_request_fatwa);
        ButterKnife.bind(this) ;
        initToolbar();

    }

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.tv_title);
        iv_background = ButterKnife.findById(mToolbar,R.id.iv_background);
        iv_logo= ButterKnife.findById(mToolbar,R.id.iv_logo);
        iv_ic=ButterKnife.findById(mToolbar,R.id.iv_ic);
        toolbar_title.setText(R.string.request_fatwa);
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

        iv_ic.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(iv_background.getContext())
                        .load(R.drawable.fatwas_icon)
                        .asBitmap()
                        .crossFade()
                        .centerCrop()
                        .override(iv_ic.getWidth(),iv_ic.getHeight())
                        .into(iv_ic);
            }
        });

        iv_logo.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(iv_logo.getContext())
                        .load(R.drawable.logo_icon)
                        .asBitmap()
                        .crossFade()
                        .centerCrop()
                        .override(iv_logo.getWidth(),iv_logo.getHeight())
                        .into(iv_logo);
            }
        });

    }


    @OnClick(R.id.btn_request_fatwa)
    public void requestFatwa(View view){

        if (et_fatwa.getText().toString().trim().isEmpty() || et_name.getText().toString().trim().isEmpty()
                || et_phone.getText().toString().trim().isEmpty() || et_email.getText().toString().trim().isEmpty()){

            AlertDialog.Builder builder;
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                builder = new AlertDialog.Builder(RequestFatwaActivity.this, android.R.style.Theme_Material_Dialog_Alert);
            } else {
                builder = new AlertDialog.Builder(RequestFatwaActivity.this);
            }
            builder.setTitle("مشكلة")
                    .setMessage("برجاء ملئ جميع البيانات")
                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            // continue with delete
                            finish();
                        }
                    })
                    .setIcon(android.R.drawable.ic_dialog_alert)
                    .show();


            return;
        }

        Log.e("Tag","REQUEST FATWA");
        AndroidNetworking.get(Url.FATWA_REQUEST)
                .addQueryParameter("question",et_fatwa.getText().toString())
                .addQueryParameter("name",et_name.getText().toString())
                .addQueryParameter("phone",et_phone.getText().toString())
                .addQueryParameter("email",et_email.getText().toString())
                .build()
                .getAsObject(ServerResponse.class, new ParsedRequestListener<ServerResponse>() {
                    @Override
                    public void onResponse(ServerResponse response) {
                        if(!response.isError()){
                            Log.e("Tag","SUCCESS FATWA");

                            AlertDialog.Builder builder;
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                                builder = new AlertDialog.Builder(RequestFatwaActivity.this, android.R.style.Theme_Material_Dialog_Alert);
                            } else {
                                builder = new AlertDialog.Builder(RequestFatwaActivity.this);
                            }
                            builder.setTitle("تم ارسال طلبك ")
                                    .setMessage("سيتم الرد على سؤالك قريبا")
                                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int which) {
                                            // continue with delete
                                            finish();
                                        }
                                    })
                                    .setIcon(android.R.drawable.ic_dialog_alert)
                                    .show();
                        }
                        else{
                            AlertDialog.Builder builder;
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                                builder = new AlertDialog.Builder(RequestFatwaActivity.this, android.R.style.Theme_Material_Dialog_Alert);
                            } else {
                                builder = new AlertDialog.Builder(RequestFatwaActivity.this);
                            }
                            builder.setTitle("مشكلة")
                                    .setMessage("يوجد مشكلة حاول ارسال سؤالك مرة اخرى")
                                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int which) {
                                            // continue with delete
                                        }
                                    })
                                    .setIcon(android.R.drawable.ic_dialog_alert)
                                    .show();
                            Log.e("Tag","ERROR FATWA");
                        }

                    }

                    @Override
                    public void onError(ANError anError) {
                        Log.e("Tag",anError.toString());

                        AlertDialog.Builder builder;
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                            builder = new AlertDialog.Builder(RequestFatwaActivity.this, android.R.style.Theme_Material_Dialog_Alert);
                        } else {
                            builder = new AlertDialog.Builder(RequestFatwaActivity.this);
                        }
                        builder.setTitle("مشكلة")
                                .setMessage("يوجد مشكلة حاول ارسال سؤالك مرة اخرى")
                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int which) {
                                        // continue with delete
                                        finish();
                                    }
                                })
                                .setIcon(android.R.drawable.ic_dialog_alert)
                                .show();                    }
                });
    }
}
