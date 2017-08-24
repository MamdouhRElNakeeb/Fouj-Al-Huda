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
import com.peekssolutions.fogalhoda.adapter.NewsAdapter;
import com.peekssolutions.fogalhoda.model.News;
import com.peekssolutions.fogalhoda.utils.Url;
import com.rx2androidnetworking.Rx2AndroidNetworking;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.Observer;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class NewsActivity extends AppCompatActivity {
    @BindView(R.id.rv_news)
    RecyclerView rv_news;
    NewsAdapter newsAdapter;
    ProgressDialog progress;
    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    TextView toolbar_title ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_news);
        ButterKnife.bind(this);
        initToolbar();
        requestNews();
        initProgress();
    }

    private void initToolbar() {
        toolbar_title=   ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        toolbar_title.setText(R.string.camp_news);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

    private void initProgress() {
        progress = new ProgressDialog(NewsActivity.this);
        progress.setMessage("من فضلك انتظر...");
        progress.setTitle("جارى تجميع الاخبار");
        progress.show();
    }

    private void requestNews() {
        Rx2AndroidNetworking.get(Url.NEWS)
                .build()
                .getObjectListObservable(News.class)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Observer<List<News>>() {
                    @Override
                    public void onSubscribe(Disposable d) {
                    }

                    @Override
                    public void onNext(List<News> news) {

                        newsAdapter = new NewsAdapter(news);
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
        rv_news.setLayoutManager(new LinearLayoutManager(this));
        rv_news.setAdapter(newsAdapter);
    }
}
