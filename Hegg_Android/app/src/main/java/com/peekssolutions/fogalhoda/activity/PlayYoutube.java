package com.peekssolutions.fogalhoda.activity;

import android.os.Bundle;
import android.util.Log;

import com.google.android.youtube.player.YouTubeBaseActivity;
import com.google.android.youtube.player.YouTubeInitializationResult;
import com.google.android.youtube.player.YouTubePlayer;
import com.google.android.youtube.player.YouTubePlayerView;
import com.peekssolutions.fogalhoda.R;

import butterknife.BindView;
import butterknife.ButterKnife;

import static com.peekssolutions.fogalhoda.R.string.GOOGLE_API_KEY;

public class PlayYoutube extends YouTubeBaseActivity {

    @BindView(R.id.youtube_player)
    YouTubePlayerView youTubePlayerView ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_play_youtube);
        ButterKnife.bind(this);
        String url=getIntent().getExtras().getString("url");

        openVideo(url);
    }

    private void openVideo(final String url) {
        youTubePlayerView.initialize(getResources().getString(GOOGLE_API_KEY), new YouTubePlayer.OnInitializedListener() {
            @Override
            public void onInitializationSuccess(YouTubePlayer.Provider provider, YouTubePlayer youTubePlayer, boolean b) {
                youTubePlayer.cueVideo(url);
            }

            @Override
            public void onInitializationFailure(YouTubePlayer.Provider provider, YouTubeInitializationResult youTubeInitializationResult) {
                Log.e("Error","Youtube Player error");
            }
        });
    }
}
