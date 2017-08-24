package com.peekssolutions.fogalhoda.model.video;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

/**
 * Created by khaled on 18/08/17.
 */

public class Items implements Serializable {


    @SerializedName("snippet")
    Snippet snippetList ;




    public Snippet getSnippetList() {
        return snippetList;
    }
}
