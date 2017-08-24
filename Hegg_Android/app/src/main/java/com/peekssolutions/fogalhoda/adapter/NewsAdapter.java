package com.peekssolutions.fogalhoda.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.model.News;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by khaled on 18/08/17.
 */

public class NewsAdapter extends RecyclerView.Adapter<NewsAdapter.NewsViewHolder> {

    List<News> list ;

    public NewsAdapter(List<News> list) {
        this.list = list;
    }

    @Override
    public NewsViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.news_item,parent,false);

        return new NewsViewHolder(view);
    }

    @Override
    public void onBindViewHolder(NewsViewHolder holder, int position) {
        holder.tv_news_title.setText(list.get(position).getTitle());
        holder.tv_news_description.setText(list.get(position).getDescription());
        holder.itemView.post(new Runnable() {
            @Override
            public void run() {

            }
        });
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    class NewsViewHolder extends RecyclerView.ViewHolder{

        @BindView(R.id.tv_news_title)
        TextView tv_news_title ;
        @BindView(R.id.iv_news_cover)
        ImageView iv_news_cover ;
        @BindView(R.id.tv_news_description)
        TextView tv_news_description ;
        @BindView(R.id.tv_news_date)
        TextView tv_news_date ;

        public NewsViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }
    }
}
