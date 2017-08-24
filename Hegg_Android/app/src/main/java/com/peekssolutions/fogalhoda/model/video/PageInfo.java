package com.peekssolutions.fogalhoda.model.video;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

/**
 * Created by khaled on 18/08/17.
 */

class PageInfo implements Serializable{
    @SerializedName("totalResults")
    int totalResults;
    @SerializedName("resultsPerPage")
    int resultsPerPage ;

}
