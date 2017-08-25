package com.peekssolutions.fogalhoda.activity;

import android.Manifest;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.widget.TextView;

import com.androidnetworking.AndroidNetworking;
import com.androidnetworking.error.ANError;
import com.androidnetworking.interfaces.BitmapRequestListener;
import com.androidnetworking.interfaces.JSONArrayRequestListener;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.adapter.PicsAdapter;
import com.peekssolutions.fogalhoda.listener.PicsListener;
import com.peekssolutions.fogalhoda.utils.PicassoImageLoader;
import com.peekssolutions.fogalhoda.utils.Url;
import com.rx2androidnetworking.Rx2AndroidNetworking;
import com.veinhorn.scrollgalleryview.MediaInfo;
import com.veinhorn.scrollgalleryview.ScrollGalleryView;

import org.json.JSONArray;
import org.json.JSONException;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PicsActivity extends AppCompatActivity implements PicsListener {
    @BindView(R.id.rv_pics)
    RecyclerView rv_pics;
    PicsAdapter picsAdapter;
    ProgressDialog progress;
    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    TextView toolbar_title ;

    @BindView(R.id.scroll_gallery_view)
    ScrollGalleryView scrollGalleryView;

    ArrayList<String> picUrls;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pics);
        ButterKnife.bind(this);
        initToolbar();
        requestGallery();
        initProgress();
    }

    private void requestGallery() {
        AndroidNetworking.get(Url.Gallery)
                .build()
                .getAsJSONArray(new JSONArrayRequestListener() {
                    @Override
                    public void onResponse(final JSONArray response) {

                        new Thread(new Runnable() {
                            @Override
                            public void run() {
                                picUrls = new ArrayList<String>();

                                for (int i=0;i<response.length();i++){
                                    try {
                                        String name = response.getString(i) ;
                                        picUrls.add(Url.PREVIEW_IMAGE + name);
                                    } catch (JSONException e) {
                                        e.printStackTrace();
                                    }
                                }
                                //picsAdapter=new PicsAdapter(list,PicsActivity.this);
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {

                                        initGallery();
                                        //initRecycler();
                                    }
                                });
                            }
                        }).start();
                    }
                    @Override
                    public void onError(ANError anError) {
                        progress.dismiss();
                        Log.e("Tag","Picture Load Error");
                    }
                });
    }

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        toolbar_title.setText(R.string.pics);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

    private void initProgress() {
        progress = new ProgressDialog(PicsActivity.this);
        progress.setMessage("من فضلك انتظر...");
        progress.setTitle("جارى تحميل الصور");
        progress.show();
    }




    private void initRecycler() {
        progress.dismiss();
        rv_pics.setLayoutManager(new GridLayoutManager(this,3));
        rv_pics.setAdapter(picsAdapter);
    }

    private void initGallery(){

        progress.dismiss();
        List<MediaInfo> infos = new ArrayList<>(picUrls.size());
        for (String url : picUrls) infos.add(MediaInfo.mediaLoader(new PicassoImageLoader(url)));

        scrollGalleryView
                .setThumbnailSize(100)
                .setZoom(true)
                .setFragmentManager(getSupportFragmentManager())
                .addMedia(infos);

    }

    private Bitmap toBitmap(int image) {
        return ((BitmapDrawable) getResources().getDrawable(image)).getBitmap();
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();
    }

    @Override
    public void openPic(String url) {

       if(isStoragePermissionGranted()) {
           Log.e("Photo","Photo CLicked");
           Log.e("photo",url) ;
            initProgress();
            Rx2AndroidNetworking.get(Url.PREVIEW_IMAGE+url)
                    .setBitmapConfig(Bitmap.Config.ARGB_8888)
                    .build()
                    .getAsBitmap(new BitmapRequestListener() {
                        @Override
                        public void onResponse(Bitmap bitmap) {
                            // do anything with bitmap
                            Uri uri = getImageUri(PicsActivity.this,bitmap);
                            Log.e("Uri",uri.toString());
                            progress.dismiss();
                            startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse(uri.toString()))); /** replace with your own uri */

                        }
                        @Override
                        public void onError(ANError error) {
                            // handle error
                            Log.e("Error",error.toString()) ;
                            progress.hide();
                        }
                    });
        }

    }

    public  boolean isStoragePermissionGranted() {
        if (Build.VERSION.SDK_INT >= 23) {
            if (checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    == PackageManager.PERMISSION_GRANTED) {
                Log.v("Permisson","Permission is granted");
                return true;
            } else {

                Log.v("Permisson","Permission is revoked");
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1);
                return false;
            }
        }
        else { //permission is automatically granted on sdk<23 upon installation
            Log.v("Permisson","Permission is granted");
            return true;
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if(grantResults[0]== PackageManager.PERMISSION_GRANTED){
            Log.v("Permisson","Permission: "+permissions[0]+ "was "+grantResults[0]);
            //resume tasks needing this permission
        }
        else {

        }
    }
    public Uri getImageUri(Context inContext, Bitmap inImage) {
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        inImage.compress(Bitmap.CompressFormat.JPEG, 100, bytes);
        String path = MediaStore.Images.Media.insertImage(inContext.getContentResolver(), inImage, "Title", null);
        return Uri.parse(path);
    }

}
