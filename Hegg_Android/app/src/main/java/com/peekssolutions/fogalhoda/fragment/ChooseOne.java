package com.peekssolutions.fogalhoda.fragment;


import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.activity.AboutUsActivity;
import com.peekssolutions.fogalhoda.activity.FatawyActivity;
import com.peekssolutions.fogalhoda.activity.Mwake3naActivity;
import com.peekssolutions.fogalhoda.activity.NewsActivity;
import com.peekssolutions.fogalhoda.activity.PicsActivity;
import com.peekssolutions.fogalhoda.activity.Tgmo3Activity;
import com.peekssolutions.fogalhoda.activity.TimelineActivity;
import com.peekssolutions.fogalhoda.activity.VideosActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;


public class ChooseOne extends Fragment {
    @BindView(R.id.iv_marker)
    ImageView iv_marker ;
    @BindView(R.id.iv_maps)
    ImageView iv_maps ;
    @BindView(R.id.iv_fatawa)
    ImageView iv_fatwa ;
    @BindView(R.id.iv_timeline)
    ImageView iv_timeline;
    @BindView(R.id.iv_gallery)
    ImageView iv_pic ;
    @BindView(R.id.iv_videos)
    ImageView iv_video ;
    @BindView(R.id.iv_about)
    ImageView iv_about ;
    @BindView(R.id.iv_news)
    ImageView iv_news ;

    public ChooseOne() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view=inflater.inflate(R.layout.choose_service_item1,container,false);
        ButterKnife.bind(this,view);

        initPics(iv_marker,R.drawable.maps_ic);
        initPics(iv_maps,R.drawable.maps_ic);
        initPics(iv_fatwa,R.drawable.fatwa_icon);
        initPics(iv_timeline,R.drawable.timeline_icon);
        initPics(iv_pic,R.drawable.gallery_icon);
        initPics(iv_video,R.drawable.videos_icon);
        initPics(iv_about,R.drawable.about_icon);
        initPics(iv_news,R.drawable.news_icon);

        return view;
    }

    public void initPics(final ImageView imageView, final int drawable){
        imageView.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(imageView.getContext())
                        .load(drawable)
                        .asBitmap()
                        .crossFade()
                        .override(imageView.getWidth(),imageView.getHeight())
                        .into(imageView);
            }
        });
    }

    @OnClick({R.id.ll_amakn_tgmo3,R.id.ll_mawk3na,R.id.ll_fatawy,
            R.id.ll_timeline,R.id.ll_pics,R.id.ll_videos,
            R.id.ll_about_us,R.id.ll_news})
    public void navigateScreen(View view) {
        switch (view.getId()){
            case R.id.ll_amakn_tgmo3:
                startActivity(new Intent(getActivity(),Tgmo3Activity.class));
                break ;
            case R.id.ll_mawk3na:
                startActivity(new Intent(getActivity(),Mwake3naActivity.class));
                break ;
            case R.id.ll_fatawy:
                startActivity(new Intent(getActivity(),FatawyActivity.class));
                break ;
            case R.id.ll_timeline:
                startActivity(new Intent(getActivity(),TimelineActivity.class));
                break ;
            case R.id.ll_pics:
                startActivity(new Intent(getActivity(),PicsActivity.class));
                break ;
            case R.id.ll_videos:
                startActivity(new Intent(getActivity(),VideosActivity.class));
                break ;
            case R.id.ll_about_us:
                startActivity(new Intent(getActivity(),AboutUsActivity.class));
                break ;
            case R.id.ll_news :
                startActivity(new Intent(getActivity(),NewsActivity.class));
                break ;
        }
    }

}
