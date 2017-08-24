package com.peekssolutions.fogalhoda.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.activity.PicsActivity;
import com.peekssolutions.fogalhoda.listener.PicsListener;
import com.peekssolutions.fogalhoda.utils.Url;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by khaled on 18/08/17.
 */

public class PicsAdapter extends RecyclerView.Adapter<PicsAdapter.PicsViewHolder> {

    List<String> list ;
    PicsListener picsListener ;

    public PicsAdapter(List<String> list, PicsActivity picsActivity) {
        this.picsListener=(PicsListener) picsActivity ;
        this.list = list;
    }

    @Override
    public PicsViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.pics_item,parent,false);

        return new PicsViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final PicsViewHolder holder, final int position) {
                holder.itemView.post(new Runnable() {
                    @Override
                    public void run() {
                        Glide.with(holder.itemView.getContext())
                                .load(Url.PREVIEW_IMAGE+list.get(position))
                                // .centerCrop()
                                .crossFade()
                                .placeholder(R.drawable.logo_icon)
                                //     .override(holder.iv_pic.getWidth(),holder.iv_pic.getHeight())
                                .into(holder.iv_pic);


                    }
                });

        holder.iv_pic.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                picsListener.openPic(list.get(position));
            }
        });

    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    class PicsViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_pic)
        ImageView iv_pic ;
        public PicsViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }
    }
}
