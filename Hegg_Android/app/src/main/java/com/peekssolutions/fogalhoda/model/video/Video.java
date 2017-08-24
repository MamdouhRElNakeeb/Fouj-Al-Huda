package com.peekssolutions.fogalhoda.model.video;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.List;

/**
 * Created by khaled on 16/08/17.
 */

public class Video implements Serializable{
   @SerializedName("items")
   List<Items> items;
    @SerializedName("kind")
    String kind ;
    @SerializedName("etag")
    String etag ;
    @SerializedName("pageInfo")
    PageInfo pageInfo ;

    public List<Items> getItems() {
        return items;
    }

    public String getKind() {
        return kind;
    }

    public String getEtag() {
        return etag;
    }

    public PageInfo getPageInfo() {
        return pageInfo;
    }
}

