package com.peekssolutions.fogalhoda.model;

/**
 * Created by khaled on 16/08/17.
 */

public class Camp {
    int id ;
    String name ;
    Double latitude ;
    Double longitue;
    String description ;

    public Camp(int id, String name, Double latitude, Double longitue, String description) {
        this.id = id;
        this.name = name;
        this.latitude = latitude;
        this.longitue = longitue;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitue() {
        return longitue;
    }

    public void setLongitue(Double longitue) {
        this.longitue = longitue;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
