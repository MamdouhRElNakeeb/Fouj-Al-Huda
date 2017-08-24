package com.peekssolutions.fogalhoda.activity;

import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.AppCompatButton;
import android.support.v7.widget.Toolbar;
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

public class ContactUsActivity extends AppCompatActivity {

    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    @BindView(R.id.btn_request_fatwa)
    AppCompatButton btn_request_chair ;
    TextView toolbar_title ;
    ImageView iv_background ;
    ImageView iv_logo ;
    ImageView iv_ic ;
    @BindView(R.id.et_fatwa)
    EditText et_phone ;
    @BindView(R.id.et_subject)
    EditText et_subject;
    @BindView(R.id.et_userID)
    EditText et_userID;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_contact_us);
        ButterKnife.bind(this) ;
        initToolbar();

    }

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.tv_title);
        iv_background = ButterKnife.findById(mToolbar,R.id.iv_background);
        iv_logo= ButterKnife.findById(mToolbar,R.id.iv_logo);
        iv_ic=ButterKnife.findById(mToolbar,R.id.iv_ic);
        toolbar_title.setText(R.string.contact_us);
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
                        .load(R.drawable.chair_icon)
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
    public void requestChair(View view){
        AndroidNetworking.get(Url.CHAIR_REQUEST)
                .addQueryParameter("userID", et_userID.getText().toString().trim())
                .addQueryParameter("subject", et_subject.getText().toString().trim())
                .addQueryParameter("msg", et_phone.getText().toString().trim())
                .build()
                .getAsObject(ServerResponse.class, new ParsedRequestListener<ServerResponse>() {
                    @Override
                    public void onResponse(ServerResponse response) {
                        if(!response.isError()){
                            AlertDialog.Builder builder;
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                                builder = new AlertDialog.Builder(ContactUsActivity.this, android.R.style.Theme_Material_Dialog_Alert);
                            } else {
                                builder = new AlertDialog.Builder(ContactUsActivity.this);
                            }
                            builder.setTitle("تم ارسال رسالتك ")
                                    .setMessage("سيتم الاتصال بك قريبا")
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
                                builder = new AlertDialog.Builder(ContactUsActivity.this, android.R.style.Theme_Material_Dialog_Alert);
                            } else {
                                builder = new AlertDialog.Builder(ContactUsActivity.this);
                            }
                            builder.setTitle("مشكلة")
                                    .setMessage("حاول ارسال رسالتك مرة اخرى")
                                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int which) {
                                            // continue with delete
                                            finish();
                                        }
                                    })
                                    .setIcon(android.R.drawable.ic_dialog_alert)
                                    .show();                        }

                    }

                    @Override
                    public void onError(ANError anError) {
                        AlertDialog.Builder builder;
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                            builder = new AlertDialog.Builder(ContactUsActivity.this, android.R.style.Theme_Material_Dialog_Alert);
                        } else {
                            builder = new AlertDialog.Builder(ContactUsActivity.this);
                        }
                        builder.setTitle("مشكلة")
                                .setMessage("حاول ارسال طلبك مرة اخرى")
                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int which) {
                                        // continue with delete
                                        finish();
                                    }
                                })
                                .setIcon(android.R.drawable.ic_dialog_alert)
                                .show();

                    }
                });
    }
}
