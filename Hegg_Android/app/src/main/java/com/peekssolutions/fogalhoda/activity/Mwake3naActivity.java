package com.peekssolutions.fogalhoda.activity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.widget.TextView;

import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.adapter.Mwak3naAdapter;
import com.peekssolutions.fogalhoda.listener.Mwake3naListener;
import com.peekssolutions.fogalhoda.model.Mawk3na;
import com.peekssolutions.fogalhoda.utils.Url;
import com.rx2androidnetworking.Rx2AndroidNetworking;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.Observer;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class Mwake3naActivity extends AppCompatActivity implements Mwake3naListener {
    @BindView(R.id.rv_mawake3na)
    RecyclerView rv_mwke3na;
    Mwak3naAdapter mwak3naAdapter;
    ProgressDialog progress;
    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    TextView toolbar_title ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mwake3na);
        ButterKnife.bind(this);
        initToolbar();
        initProgress();
        requestCampLocations();
    }

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        toolbar_title.setText(R.string.mawke3na);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

    private void initProgress() {
        progress = new ProgressDialog(Mwake3naActivity.this);
        progress.setMessage("من فضلك انتظر...");
        progress.setTitle("جارى تجميع البيانات");
        progress.show();
    }

    private void requestCampLocations() {
        Rx2AndroidNetworking.get(Url.MWAKE3NA)
                .build()
                .getObjectListObservable(Mawk3na.class)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Observer<List<Mawk3na>>() {
                    @Override
                    public void onSubscribe(Disposable d) {

                    }

                    @Override
                    public void onNext(final List<Mawk3na> mawk3nas) {
                        Log.e("Tag","Next");
                        new Thread(new Runnable() {
                            @Override
                            public void run() {
                                mwak3naAdapter=new Mwak3naAdapter(mawk3nas,Mwake3naActivity.this);
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        initRecycler();
                                    }
                                });
                            }
                        }).start();
                    }

                    @Override
                    public void onError(Throwable e) {
                        Log.e("error","error");
                        progress.hide();
                    }

                    @Override
                    public void onComplete() {
                        progress.dismiss();
                    }
                });
    }

    private void initRecycler() {
        rv_mwke3na.setLayoutManager(new LinearLayoutManager(this));
        rv_mwke3na.setAdapter(mwak3naAdapter);
    }


    @Override
    public void openMap(String title, String description, double lat, double lon) {
        Intent intent=new Intent(this,MapsActivity.class);
        intent.putExtra("title",title);
        intent.putExtra("description",description);
        intent.putExtra("lat",lat);
        intent.putExtra("lon",lon);
        startActivity(intent);
    }
}
