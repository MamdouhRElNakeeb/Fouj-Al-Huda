package com.peekssolutions.fogalhoda.activity;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.widget.TextView;

import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.adapter.TimelineAdapter;
import com.peekssolutions.fogalhoda.model.Timeline;
import com.peekssolutions.fogalhoda.utils.Url;
import com.rx2androidnetworking.Rx2AndroidNetworking;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.Observer;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class TimelineActivity extends AppCompatActivity {
    @BindView(R.id.rv_timeline)
    RecyclerView rv_timeline;
    TimelineAdapter timelineAdapter;
    ProgressDialog progress;
    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    TextView toolbar_title ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_timeline);
        ButterKnife.bind(this);
        initToolbar();
        requesTimeline();
        initProgress();
    }

    private void requesTimeline() {
        Rx2AndroidNetworking.get(Url.TIMELINE)
                .build()
                .getObjectListObservable(Timeline.class)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Observer<List<Timeline>>() {
                    @Override
                    public void onSubscribe(Disposable d) {
                    }

                    @Override
                    public void onNext(final List<Timeline> timelines) {
                        new Handler().post(new Runnable() {
                            @Override
                            public void run() {
                                timelineAdapter = new TimelineAdapter(timelines,TimelineActivity.this);
                                initRecycler();
                            }
                        });
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

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        toolbar_title.setText(R.string.timeline);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

    private void initProgress() {
        progress = new ProgressDialog(TimelineActivity.this);
        progress.setMessage("من فضلك انتظر...");
        progress.setTitle("جارى عمل الجدول الزمنى");
        progress.show();
    }




    private void initRecycler() {
        rv_timeline.setLayoutManager(new LinearLayoutManager(this));
        rv_timeline.setAdapter(timelineAdapter);
    }

}
