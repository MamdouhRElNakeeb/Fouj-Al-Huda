package com.peekssolutions.fogalhoda.model;

/**
 * Created by khaled on 16/08/17.
 */

public class News {
    int id ;
    String title ;
    String description;
    String image ;
    int timeInMills;

    public News(int id, String title, String description, String image, int timeInMills) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.image = image;
        this.timeInMills = timeInMills;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getTimeInMills() {
        return timeInMills;
    }

    public void setTimeInMills(int timeInMills) {
        this.timeInMills = timeInMills;
    }
}
