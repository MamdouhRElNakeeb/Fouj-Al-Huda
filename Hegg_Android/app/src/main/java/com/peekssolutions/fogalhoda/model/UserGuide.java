package com.peekssolutions.fogalhoda.model;

import android.webkit.URLUtil;

/**
 * Created by khaled on 20/08/17.
 */

public class UserGuide {
    String id ;
    String name ;
    String image ;
    String pdf ;
    String file_name ;

    public String getFile_name() {
        return URLUtil.guessFileName(pdf, null, null);
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getImage() {
        return image;
    }

    public String getPdf() {
        return pdf;
    }
}
