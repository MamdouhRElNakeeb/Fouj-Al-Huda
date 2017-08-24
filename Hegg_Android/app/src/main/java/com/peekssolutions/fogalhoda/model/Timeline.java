package com.peekssolutions.fogalhoda.model;

/**
 * Created by khaled on 18/08/17.
 */

public class Timeline {
    public String name;
    public int mDate;
    public TimelineStatus mStatus;
    public String description;
    public long timeInMillis;

    public Timeline(String name, int mDate, TimelineStatus mStatus, String description, long timeInMillis) {
        this.name = name;
        this.mDate = mDate;
        this.mStatus = mStatus;
        this.description = description;
        this.timeInMillis = timeInMillis;
    }

    public long getTimeInMillis() {
        return timeInMillis;
    }

    public void setTimeInMillis(long timeInMillis) {
        this.timeInMillis = timeInMillis;
    }

    public TimelineStatus getmStatus() {
        return TimelineStatus.INACTIVE;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getmDate() {
        return mDate;
    }

    public void setmDate(int mDate) {
        this.mDate = mDate;
    }

    public void setmStatus(TimelineStatus mStatus) {
        this.mStatus = mStatus;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
