package com.peekssolutions.fogalhoda.model.video;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

/**
 * Created by khaled on 18/08/17.
 */

public class Snippet implements Serializable {
    @SerializedName("title")
    String title ;
    @SerializedName("thumbnails")
    Thumbnail thumbnail ;
    @SerializedName("resourceId")
    VideoResource videoResources ;

    public VideoResource getVideoResources() {
        return videoResources;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Thumbnail getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(Thumbnail thumbnail) {
        this.thumbnail = thumbnail;
    }


}
