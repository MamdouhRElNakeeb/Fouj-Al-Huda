package com.peekssolutions.fogalhoda.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.listener.Mwake3naListener;
import com.peekssolutions.fogalhoda.model.Mawk3na;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by khaled on 18/08/17.
 */

public class Mwak3naAdapter extends RecyclerView.Adapter<Mwak3naAdapter.Mwak3naViewHolder> {

    List<Mawk3na> list ;
    Mwake3naListener mwake3naListener ;
    public Mwak3naAdapter(List<Mawk3na> list,Context context) {
        this.list = list;
        this.mwake3naListener = (Mwake3naListener) context;
    }

    @Override
    public Mwak3naViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.mwak3na_item,parent,false);

        return new Mwak3naViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final Mwak3naViewHolder holder, final int position) {
        holder.tv_title.setText(list.get(position).getName());
        holder.tv_description.setText(list.get(position).getDescription());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mwake3naListener.openMap(list.get(position).getName(),
                                list.get(position).getDescription(),
                                list.get(position).getLatitude(),list.get(position).getLongitude());
            }
        });
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    class Mwak3naViewHolder extends RecyclerView.ViewHolder{

        @BindView(R.id.tv_title)
        TextView tv_title ;
        @BindView(R.id.tv_description)
        TextView tv_description ;

        public Mwak3naViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }
    }
}
