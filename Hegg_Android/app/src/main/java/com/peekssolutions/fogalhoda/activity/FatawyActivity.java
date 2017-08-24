package com.peekssolutions.fogalhoda.activity;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.widget.TextView;

import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.adapter.FatwaAdapter;
import com.peekssolutions.fogalhoda.model.Fatwa;
import com.peekssolutions.fogalhoda.utils.Url;
import com.rx2androidnetworking.Rx2AndroidNetworking;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.Observer;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class FatawyActivity extends AppCompatActivity {
    @BindView(R.id.rv_fatawy)
    RecyclerView rv_fatawy;
    FatwaAdapter fatwaAdapter;
    ProgressDialog progress;

    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    TextView toolbar_title ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fatawy);
        ButterKnife.bind(this);
        initToolbar();
        requestFatawy();
        initProgress();
    }

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        toolbar_title.setText(R.string.fatawy);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

    private void initProgress() {
        progress = new ProgressDialog(FatawyActivity.this);
        progress.setMessage("من فضلك انتظر...");
        progress.setTitle("جارى تجميع الفتاوى");
        progress.show();
    }

    private void requestFatawy() {
        Rx2AndroidNetworking.get(Url.GET_FATWA)
                .build()
                .getObjectListObservable(Fatwa.class)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Observer<List<Fatwa>>() {
                    @Override
                    public void onSubscribe(Disposable d) {

                    }

                    @Override
                    public void onNext(final List<Fatwa> fatawy) {

                       new Thread(new Runnable() {
                           @Override
                           public void run() {
                               fatwaAdapter = new FatwaAdapter(fatawy);
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
        rv_fatawy.setLayoutManager(new LinearLayoutManager(this));
        rv_fatawy.setAdapter(fatwaAdapter);
    }
}
