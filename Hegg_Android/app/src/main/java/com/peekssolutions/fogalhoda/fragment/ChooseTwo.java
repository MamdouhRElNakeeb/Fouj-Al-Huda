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
import com.peekssolutions.fogalhoda.activity.ContactUsActivity;
import com.peekssolutions.fogalhoda.activity.HaggTayehActivity;
import com.peekssolutions.fogalhoda.activity.RequestChairActivity;
import com.peekssolutions.fogalhoda.activity.RequestFatwaActivity;
import com.peekssolutions.fogalhoda.activity.UserGuideActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class ChooseTwo extends Fragment {

    @BindView(R.id.iv_user_guide)
    ImageView iv_user_guide ;
    @BindView(R.id.iv_request_chair)
    ImageView iv_request_chair ;
    @BindView(R.id.iv_request_fatawa)
    ImageView iv_request_fatwa ;
    @BindView(R.id.iv_hagg_daye3)
    ImageView iv_hagg_daye3;
    @BindView(R.id.iv_contact_us)
    ImageView iv_contact_us;

    public ChooseTwo() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View itemView=inflater.inflate(R.layout.choose_service_item2,container,false);
        ButterKnife.bind(this,itemView);

        initPics(iv_user_guide,R.drawable.guide_ic);
        initPics(iv_request_chair,R.drawable.chair_icon);
        initPics(iv_request_fatwa,R.drawable.fatwa_icon);
        initPics(iv_hagg_daye3,R.drawable.marker_icon);
        initPics(iv_contact_us,R.drawable.contact_icon);

        return itemView;
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

    @OnClick({R.id.ll_user_guide,R.id.ll_request_chair,R.id.ll_request_fatwa,R.id.ll_hagg_daye3, R.id.ll_contact_us})
    public void navToScreen(View view) {
        switch (view.getId()){
            case R.id.ll_user_guide:
                startActivity(new Intent(getActivity(),UserGuideActivity.class));
                break ;
            case R.id.ll_request_chair:
                startActivity(new Intent(getActivity(),RequestChairActivity.class));
                break ;
            case R.id.ll_request_fatwa:
                startActivity(new Intent(getActivity(),RequestFatwaActivity.class));
                break ;
            case R.id.ll_hagg_daye3:
                startActivity(new Intent(getActivity(),HaggTayehActivity.class));
                break ;
            case R.id.ll_contact_us:
                startActivity(new Intent(getActivity(),ContactUsActivity.class));
                break ;
        }
    }

}
