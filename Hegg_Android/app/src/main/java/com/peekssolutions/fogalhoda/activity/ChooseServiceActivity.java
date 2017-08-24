package com.peekssolutions.fogalhoda.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.NavigationView;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Gravity;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.peekssolutions.fogalhoda.R;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ChooseServiceActivity extends AppCompatActivity {
    @BindView(R.id.toolbar)
    Toolbar mToolbar ;
    TextView tv_toolbar_title ;
    @BindView(R.id.navigation_view)
    NavigationView navigationView ;
    @BindView(R.id.drawer)
    DrawerLayout drawerLayout;
    @BindView(R.id.background)
    ImageView iv_background ;
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


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_service);
        ButterKnife.bind(this);

        initPics(iv_background,R.drawable.splash_bg);
        initPics(iv_marker,R.drawable.maps_ic);
        initPics(iv_maps,R.drawable.maps_ic);
        initPics(iv_fatwa,R.drawable.fatwa_icon);
        initPics(iv_timeline,R.drawable.timeline_icon);
        initPics(iv_pic,R.drawable.gallery_icon);
        initPics(iv_video,R.drawable.videos_icon);
        initPics(iv_about,R.drawable.about_icon);
        initPics(iv_news,R.drawable.news_icon);

        initToolbar();
        initNavigationDrawer();
       // getWindow().getDecorView().setLayoutDirection(View.LAYOUT_DIRECTION_RTL);


    }

 private void initNavigationDrawer() {
     
     navigationView.setNavigationItemSelectedListener(new NavigationView.OnNavigationItemSelectedListener() {
         @Override
         public boolean onNavigationItemSelected(MenuItem menuItem) {

             int id = menuItem.getItemId();

             switch (id){
                /*
                *android:id="@+id/home"
        android:id="@+id/timeline"
        android:id="@+id/videos"
        android:id="@+id/pic"
        android:id="@+id/news"
        <item android:id="@+id/request_chair"

            android:id="@+id/about"
                 */
                 case R.id.tgmo3:
                     startActivity(new Intent(ChooseServiceActivity.this,Tgmo3Activity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.mwk3na   :
                     startActivity(new Intent(ChooseServiceActivity.this,Mwake3naActivity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.ll_fatawy:
                     startActivity(new Intent(ChooseServiceActivity.this,FatawyActivity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.timeline:
                     startActivity(new Intent(ChooseServiceActivity.this,TimelineActivity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.pic:
                     startActivity(new Intent(ChooseServiceActivity.this,PicsActivity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.videos:
                     startActivity(new Intent(ChooseServiceActivity.this,VideosActivity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.about:
                     startActivity(new Intent(ChooseServiceActivity.this,AboutUsActivity.class));
                     drawerLayout.closeDrawers();
                     break ;

                 case R.id.news :
                     startActivity(new Intent(ChooseServiceActivity.this, NewsActivity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.request_chair:
                     startActivity(new Intent(ChooseServiceActivity.this,RequestChairActivity.class));
                     drawerLayout.closeDrawers();

                     break ;
                 case R.id.request_fatwa:
                     startActivity(new Intent(ChooseServiceActivity.this,RequestFatwaActivity.class));
                     drawerLayout.closeDrawers();
                     break ;
                 case R.id.user_guide :
                     startActivity(new Intent(ChooseServiceActivity.this,UserGuideActivity.class));
                     drawerLayout.closeDrawers();
                     break ;
                 case R.id.contact_us:
                     startActivity(new Intent(ChooseServiceActivity.this,ContactUsActivity.class));
                     drawerLayout.closeDrawers();
                     break;
             }
             return true;
         }
     });

        ActionBarDrawerToggle actionBarDrawerToggle = new ActionBarDrawerToggle(this,drawerLayout,mToolbar,R.string.drawer_open,R.string.drawer_close){

            @Override
            public void onDrawerClosed(View v){
                super.onDrawerClosed(v);

            }

            @Override
            public void onDrawerOpened(View v) {
                super.onDrawerOpened(v);
            }
        };
        drawerLayout.addDrawerListener(actionBarDrawerToggle);
        actionBarDrawerToggle.syncState();

        mToolbar.setNavigationOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                if (drawerLayout.isDrawerOpen(Gravity.END)) {
                    drawerLayout.closeDrawer(Gravity.END);
                } else {
                    drawerLayout.openDrawer(Gravity.END);
                }
            }
        });
    }

    private void initToolbar() {
        tv_toolbar_title=   ButterKnife.findById(mToolbar,R.id.toolbarText);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
        tv_toolbar_title.setText(R.string.welcome);

    }

    @OnClick({R.id.ll_amakn_tgmo3,R.id.ll_mawk3na,R.id.ll_fatawy,
            R.id.ll_timeline,R.id.ll_pics,R.id.ll_videos,
            R.id.ll_about_us,R.id.ll_news})
    public void navigateScreen(View view) {
        switch (view.getId()){
            case R.id.ll_amakn_tgmo3:
                startActivity(new Intent(this,Tgmo3Activity.class));
                break ;
            case R.id.ll_mawk3na:
                startActivity(new Intent(this,Mwake3naActivity.class));
                break ;
            case R.id.ll_fatawy:
                startActivity(new Intent(this,FatawyActivity.class));
                break ;
            case R.id.ll_timeline:
                startActivity(new Intent(this,TimelineActivity.class));
                break ;
            case R.id.ll_pics:
                startActivity(new Intent(this,PicsActivity.class));
                break ;
            case R.id.ll_videos:
                startActivity(new Intent(this,VideosActivity.class));
                break ;
            case R.id.ll_about_us:
                startActivity(new Intent(this,AboutUsActivity.class));
                break ;
            case R.id.ll_news :
                startActivity(new Intent(this,NewsActivity.class));
                break ;
        }
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
}
