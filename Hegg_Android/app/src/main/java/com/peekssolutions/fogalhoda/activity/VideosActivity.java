package com.peekssolutions.fogalhoda.activity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.widget.TextView;

import com.google.android.youtube.player.YouTubePlayerView;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.adapter.VideosAdapter;
import com.peekssolutions.fogalhoda.listener.YoutubeListener;
import com.peekssolutions.fogalhoda.model.video.Items;
import com.peekssolutions.fogalhoda.model.video.Video;
import com.peekssolutions.fogalhoda.utils.Url;
import com.rx2androidnetworking.Rx2AndroidNetworking;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.Observer;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.disposables.Disposable;
import io.reactivex.functions.Function;
import io.reactivex.schedulers.Schedulers;

public class VideosActivity extends AppCompatActivity implements YoutubeListener {

    VideosAdapter videosAdapter ;
    ProgressDialog progress;
    YouTubePlayerView youTubePlayer ;
    @BindView(R.id.rv_videos)
    RecyclerView rv_videos ;

    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    TextView toolbar_title ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_videos);
        ButterKnife.bind(this);
        requestVideos();
        initToolbar();
    }

    private void requestVideos() {
        Rx2AndroidNetworking.get(Url.videosUrl)
                .build()
                .getObjectObservable(Video.class)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .map(new Function<Video, List<Items>>() {
                    @Override
                    public List<Items> apply(@NonNull Video video) throws Exception {
                        return video.getItems();
                    }
                })
                .subscribe(new Observer<List<Items>>() {
                    @Override
                    public void onSubscribe(Disposable d) {
                    }

                    @Override
                    public void onNext(final List<Items> itemses) {
                        Log.e("Tag","Next");

                        new Handler().post(new Runnable() {
                            @Override
                            public void run() {
                                videosAdapter=new VideosAdapter(itemses,VideosActivity.this);
                                initRecycler();
                            }
                        });
                    }

                    @Override
                    public void onError(Throwable e) {
                        // handle error
                       // progress.hide();
                        Log.e("TAG", e.toString());
                    }

                    @Override
                    public void onComplete() {
                        //progress.dismiss();
                    }
                });
    }

    private void initRecycler() {
        rv_videos.setLayoutManager(new LinearLayoutManager(this));
        rv_videos.setAdapter(videosAdapter);
    }

    @Override
    public void selectVideo(String url) {
        startActivity(new Intent(VideosActivity.this,PlayYoutube.class).putExtra("url",url));
    }

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        toolbar_title.setText(R.string.videos);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }
}
