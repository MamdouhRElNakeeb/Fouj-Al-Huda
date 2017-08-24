package com.peekssolutions.fogalhoda.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.github.vipulasri.timelineview.TimelineView;
import com.peekssolutions.fogalhoda.R;
import com.peekssolutions.fogalhoda.model.Timeline;
import com.peekssolutions.fogalhoda.model.TimelineStatus;
import com.peekssolutions.fogalhoda.utils.DatetimeUtils;
import com.peekssolutions.fogalhoda.utils.VectorDrawableUtils;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by khaled on 18/08/17.
 */

public class TimelineAdapter extends RecyclerView.Adapter<TimelineAdapter.TimelineViewHolder> {
    List<Timeline>list;
    Context mContext ;

    public TimelineAdapter(List<Timeline> list,Context mContext) {
        this.list = list;
        this.mContext=mContext;
    }

    @Override
    public TimelineViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.timelineitem,parent,false);

        return new TimelineViewHolder(view,viewType);
    }

    @Override
    public int getItemViewType(int position) {
        return TimelineView.getTimeLineViewType(position,getItemCount());
    }

    @Override
    public void onBindViewHolder(TimelineViewHolder holder, int position) {
        Timeline timeLineModel = list.get(position);

        if(timeLineModel.getmStatus() == TimelineStatus.INACTIVE) {
            holder.mTimelineView.setMarker(VectorDrawableUtils.getDrawable(mContext, R.drawable.ic_marker_inactive, android.R.color.darker_gray));
        } else if(timeLineModel.getmStatus() == TimelineStatus.ACTIVE) {
            holder.mTimelineView.setMarker(VectorDrawableUtils.getDrawable(mContext, R.drawable.ic_marker_active, R.color.colorPrimary));
        } else {
            holder.mTimelineView.setMarker(ContextCompat.getDrawable(mContext, R.drawable.ic_marker), ContextCompat.getColor(mContext, R.color.colorPrimary));
        }

            holder.mDate.setVisibility(View.VISIBLE);
            holder.mDate.setText(DatetimeUtils.parseDateTime("2017-02-11 09:30", "yyyy-MM-dd HH:mm", "hh:mm a, dd-MMM-yyyy"));

        holder.mMessage.setText(timeLineModel.getName());
        holder.timeline_description.setText(timeLineModel.getDescription());
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    class TimelineViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.text_timeline_date)
        TextView mDate;
        @BindView(R.id.text_timeline_title)
        TextView mMessage;
        @BindView(R.id.time_marker)
        TimelineView mTimelineView;
        @BindView(R.id.text_timeline_description)
        TextView timeline_description ;

        public TimelineViewHolder(View itemView,int viewType) {
            super(itemView);
            ButterKnife.bind(this,itemView);
            mTimelineView.initLine(viewType);
        }
    }
}
