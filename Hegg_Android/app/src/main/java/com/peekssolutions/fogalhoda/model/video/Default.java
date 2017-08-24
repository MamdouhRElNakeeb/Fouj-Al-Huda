package com.peekssolutions.fogalhoda.model.video;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

/**
 * Created by khaled on 18/08/17.
 */

public class Default implements Serializable {
    @SerializedName("url")
    String url ;
    @SerializedName("height")
    int height ;
    @SerializedName("width")
    int width ;

    public String getUrl() {
        return url;
    }

    public int getHeight() {
        return height;
    }

    public int getWidth() {
        return width;
    }
}
