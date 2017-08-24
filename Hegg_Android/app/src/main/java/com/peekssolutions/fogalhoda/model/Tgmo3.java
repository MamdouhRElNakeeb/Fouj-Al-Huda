package com.peekssolutions.fogalhoda.model;

/**
 * Created by khaled on 18/08/17.
 */

public class Tgmo3 {

    String title ;
    double lat,lng ;

    public Tgmo3(String title, double lat, double lng) {
        this.title = title;
        this.lat = lat;
        this.lng = lng;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }
}
