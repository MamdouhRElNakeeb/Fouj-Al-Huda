package com.peekssolutions.fogalhoda.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.listener.FatwaListener;
import com.peekssolutions.fogalhoda.model.Fatwa;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by khaled on 18/08/17.
 */

public class FatwaAdapter extends RecyclerView.Adapter<FatwaAdapter.FatwaViewHolder> {

    List<Fatwa> list ;
    FatwaListener fatwaListener;
    public FatwaAdapter(List<Fatwa> list) {
        this.list = list;
    }

    @Override
    public FatwaViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.fatawa_item,parent,false);

        return new FatwaViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final FatwaViewHolder holder, final int position) {
        holder.tv_title.setText(list.get(position).getQuestion());
        holder.btn_show_answer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                holder.ll_fatwa.setGravity(Gravity.END);
                holder.btn_show_answer.setVisibility(View.GONE);
                holder.tv_answer.setText(list.get(position).getAnswer());
                holder.tv_answer.setVisibility(View.VISIBLE);
            }
        });
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    class FatwaViewHolder extends RecyclerView.ViewHolder{

        @BindView(R.id.tv_question)
        TextView tv_title ;
        @BindView(R.id.tv_answer)
        TextView tv_answer ;
        @BindView(R.id.btn_show_answer)
        Button btn_show_answer ;
        @BindView(R.id.ll_fatwa)
        LinearLayout ll_fatwa ;

        public FatwaViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }
    }
}
