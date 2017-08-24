package com.peekssolutions.fogalhoda.adapter;

import android.content.Context;
import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.listener.YoutubeListener;
import com.peekssolutions.fogalhoda.model.video.Items;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by khaled on 18/08/17.
 */

public class VideosAdapter extends RecyclerView.Adapter<VideosAdapter.VideosViewHolder> {

   List<Items> list ;
    YoutubeListener youtubeListener ;

    public VideosAdapter(List<Items> list,Context context) {
        this.list = list;
        this.youtubeListener= (YoutubeListener) context;
    }

    @Override
    public VideosViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.video_item,parent,false);
        return new VideosViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final VideosViewHolder holder, final int position) {
        holder.tv_video_title.setText(list.get(position).getSnippetList().getTitle());
        holder.itemView.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(holder.itemView.getContext())
                        .load(list.get(position).getSnippetList().getThumbnail().getaDefault().getUrl())
                        .centerCrop()
                        .crossFade()
                        .override(holder.iv_thumbnail.getWidth(),holder.iv_thumbnail.getHeight())
                        .into(holder.iv_thumbnail);
            }
        });
        holder.cv_video.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                youtubeListener.selectVideo(list.get(position).getSnippetList().getVideoResources().getId());
            }
        });
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    public class VideosViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.video_title)
        TextView tv_video_title;
        @BindView(R.id.cv_video)
        CardView cv_video ;
        @BindView(R.id.iv_thumbnail)
        ImageView iv_thumbnail ;

        public VideosViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }
    }
}
