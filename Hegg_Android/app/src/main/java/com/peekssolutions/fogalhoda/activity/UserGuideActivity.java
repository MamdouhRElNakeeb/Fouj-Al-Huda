package com.peekssolutions.fogalhoda.activity;

import android.Manifest;
import android.app.ProgressDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v4.content.LocalBroadcastManager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.widget.TextView;

import com.peekssolutions.fogalhoda.DownloadService;
import com.peekssolutions.fogalhoda.Hegg;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.adapter.UserGuideAdapter;
import com.peekssolutions.fogalhoda.listener.BookListener;
import com.peekssolutions.fogalhoda.model.Download;
import com.peekssolutions.fogalhoda.model.UserGuide;
import com.peekssolutions.fogalhoda.utils.Url;
import com.rx2androidnetworking.Rx2AndroidNetworking;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.Observer;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class UserGuideActivity extends AppCompatActivity implements BookListener{

    public static final String MESSAGE_PROGRESS = "book_progress";
    private static final int PERMISSION_REQUEST_CODE = 2;
    UserGuideAdapter userGuideAdapter ;
    @BindView(R.id.rv_user_guide)
    RecyclerView rv_user_guide;
    ProgressDialog progress;
    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    TextView toolbar_title ;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_guide);
        ButterKnife.bind(this);
        initToolbar();
        initProgressbar();
        requestPdf();
        registerReceiver();
    }

    private void initProgressbar() {
        progress = new ProgressDialog(UserGuideActivity.this);
        progress.setMessage("من فضلك انتظر...");
        progress.setTitle("جارى تجميع البيانات");
        progress.show();
    }

    private void requestPdf() {
        Rx2AndroidNetworking.get(Url.USER_GUIDE_REQUEST)
                .build()
                .getObjectListObservable(UserGuide.class)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Observer<List<UserGuide>>() {
                    @Override
                    public void onSubscribe(Disposable d) {
                    }

                    @Override
                    public void onNext(List<UserGuide> userGuideList) {

                        userGuideAdapter = new UserGuideAdapter(userGuideList,UserGuideActivity.this);
                        initRecycler();
                    }

                    @Override
                    public void onError(Throwable e) {
                        // handle error
                        progress.hide();
                        Log.e("TAG", e.toString());
                    }

                    @Override
                    public void onComplete() {
                        progress.dismiss();
                    }
                });

    }

    private void initRecycler() {
        rv_user_guide.setLayoutManager(new LinearLayoutManager(this));
        rv_user_guide.setAdapter(userGuideAdapter);
    }

    private void initToolbar() {
        toolbar_title = ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        toolbar_title.setText(R.string.user_guide);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public void downloadBook(String Url, String File_Name, int adapterPosition) {
        if(!checkPermission())
            requestPermission();
        else{
            Intent intent = new Intent(this,DownloadService.class);
            intent.putExtra("File_Name",File_Name);
            intent.putExtra("File_Link",Url);
            intent.putExtra("File_Position",adapterPosition);
            startService(intent);
        }
    }



    @Override
    public void openBook(String filePath) {
        Log.e("OpenBook Function",filePath);
        startActivity(new Intent(this,ReadPdfActivity.class).putExtra("file_path",filePath));
        finish();
    }

    @Override
    public void openBookFromNetwork(String url) {
        if(!checkPermission())
            requestPermission();
        else {
            startActivity(new Intent(this, ReadPdfActivity.class).putExtra("URL", url));
            finish();
        }
    }

    private void registerReceiver(){
        LocalBroadcastManager bManager = LocalBroadcastManager.getInstance(this);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(MESSAGE_PROGRESS);
        bManager.registerReceiver(broadcastReceiver, intentFilter);
    }


    private boolean checkPermission(){
        int result = ContextCompat.checkSelfPermission(this,
                Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if (result == PackageManager.PERMISSION_GRANTED){

            return true;

        } else {

            return false;
        }
    }

    private void requestPermission(){
        ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},PERMISSION_REQUEST_CODE);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
        switch (requestCode) {
            case PERMISSION_REQUEST_CODE:
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {

                    Hegg.createPackageFolder();
                } else {

                    Snackbar.make(findViewById(R.id.mainLayout),"Permission Denied, Please allow to proceed !", Snackbar.LENGTH_LONG).show();

                }
                break;
        }
    }


    private BroadcastReceiver broadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {

            if(intent.getAction().equals(MESSAGE_PROGRESS)){

                Download download = intent.getParcelableExtra("download");
                Log.e("Progress",String.valueOf(download.getProgress()));

                if(download.getProgress() == 100){
                    userGuideAdapter.notifyItemChanged(intent.getIntExtra("position",0));
                    Log.e("Broadcast Complete",intent.getStringExtra("File_Name"));
                    Log.e("Broadcast Complete",Hegg.path(intent.getStringExtra("File_Name")));

                    openBook(Hegg.path(intent.getStringExtra("File_Name")));
                } else {
                    Log.i("TAG",String.format("Downloaded (%d/%d) MB",download.getCurrentFileSize(),download.getTotalFileSize()));
                }
            }
        }
    };

}
