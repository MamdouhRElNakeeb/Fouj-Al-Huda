package com.peekssolutions.fogalhoda.listener;

/**
 * Created by khaled on 20/08/17.
 */

public interface BookListener {
    void downloadBook(String Url, String File_Name,int adapterPosition);
    void openBook(String filePath);
    void openBookFromNetwork(String url);
}
