package com.peekssolutions.fogalhoda.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.peekssolutions.fogalhoda.Hegg;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.listener.BookListener;
import com.peekssolutions.fogalhoda.model.UserGuide;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

import static com.peekssolutions.fogalhoda.R.id.btn;

/**
 * Created by khaled on 20/08/17.
 */

public class UserGuideAdapter extends RecyclerView.Adapter<UserGuideAdapter.UserGuideVH> {

    List<UserGuide> list;
    BookListener bookListener ;
    public UserGuideAdapter(List<UserGuide> list, Context context) {
        this.list = list;
        this.bookListener=(BookListener) context ;
    }

    @Override
    public UserGuideVH onCreateViewHolder(ViewGroup parent, int viewType) {
        return new UserGuideVH(LayoutInflater.from(parent.getContext()).inflate(R.layout.user_guide_item,parent,false));
    }

    @Override
    public void onBindViewHolder(final UserGuideVH holder, final int position) {


        String file_name = Hegg.path(list.get(holder.getAdapterPosition()).getFile_name()) ;
        final int pos = holder.getAdapterPosition();

        holder.tv_title.setText(list.get(pos).getName());

        if(Hegg.checkExist(file_name)){
            holder.btn_download.setVisibility(View.GONE);
            holder.pb.setVisibility(View.GONE);
            holder.btn_read.setVisibility(View.VISIBLE);
        }


        holder.iv_cover.post(new Runnable() {
            @Override
            public void run() {
                Glide.with(holder.iv_cover.getContext())
                        .load(list.get(pos).getImage())
                        .asBitmap()
                        .crossFade()
                        .override(holder.iv_cover.getWidth(),holder.iv_cover.getHeight())
                        .into(holder.iv_cover);
            }
        });

        holder.btn_download.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
             /*   holder.pb.setVisibility(View.VISIBLE);
                holder.btn_download.setVisibility(View.GONE);
                String url =list.get(holder.getAdapterPosition()).getPdf() ;
                String file_name=list.get(holder.getAdapterPosition()).getFile_name();
                bookListener.downloadBook(url,file_name,holder.getAdapterPosition());*/
                bookListener.openBookFromNetwork(list.get(holder.getAdapterPosition()).getPdf());

            }
        });

        holder.btn_read.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String current_file = Hegg.path(list.get(holder.getAdapterPosition()).getFile_name()) ;
                if(Hegg.checkExist(current_file)){
                   // bookListener.openBook(Hegg.path(list.get(holder.getAdapterPosition()).getFile_name()));
                    bookListener.openBookFromNetwork(list.get(holder.getAdapterPosition()).getPdf());
                }
                else {
                    holder.btn_download.setVisibility(View.VISIBLE);
                    holder.btn_read.setVisibility(View.GONE);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    public class UserGuideVH extends RecyclerView.ViewHolder {
        @BindView(btn)
        Button btn_download ;
        @BindView(R.id.tv_title)
        TextView tv_title ;
        @BindView(R.id.tv_description)
        TextView tv_description;
        @BindView(R.id.btn_read)
        Button btn_read ;
        @BindView(R.id.pb)
        ProgressBar pb ;
        @BindView(R.id.iv_guide_cover)
        ImageView iv_cover ;

        public UserGuideVH(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }
    }
}
