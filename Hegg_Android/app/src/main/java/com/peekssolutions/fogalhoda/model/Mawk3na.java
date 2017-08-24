package com.peekssolutions.fogalhoda.model;

/**
 * Created by khaled on 18/08/17.
 */

public class Mawk3na {

    String id,name,latitude,longitude,description ;

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getLatitude() {
        return Double.valueOf(latitude);
    }

    public double getLongitude() {
        return Double.valueOf(longitude);
    }

    public String getDescription() {
        return description;
    }
}
