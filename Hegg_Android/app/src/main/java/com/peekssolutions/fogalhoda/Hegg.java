package com.peekssolutions.fogalhoda;


import android.app.Application;
import android.os.Environment;
import android.util.Log;

import com.androidnetworking.AndroidNetworking;

import java.io.File;

/**
 * Created by khaled on 16/08/17.
 */

public class Hegg extends Application {

    public static final String PACKAGE_NAME = "com.khaled.hegg" ;

    @Override
    public void onCreate() {
        super.onCreate();

        AndroidNetworking.initialize(getApplicationContext());
    }

    public static String createPackageFolder()
    {
        String extStorageDirectory = Environment
                .getExternalStorageDirectory().toString();
        File folder = new File(extStorageDirectory, "/Android/data/" + PACKAGE_NAME);

        if(!folder.exists())
        {
            folder.mkdir();
            Log.e("Created", "Folder Created At :" + folder.getPath().toString() ) ;
            createFolder();
        }
        else
        {
            Log.e("exist", "Folder Created At :" + folder.getPath().toString() ) ;
            createFolder() ;
        }
        return folder.getPath().toString();
    }


    public static String createFolder()
    {
        String extStorageDirectory = Environment
                .getExternalStorageDirectory().toString();
        File folder = new File(extStorageDirectory, "/Android/data/" + PACKAGE_NAME+"/UserGuide");
        if(!folder.exists())
        {
            folder.mkdir();
            Log.e("CreateFolder_function", "Folder Created At :" + folder.getPath().toString() ) ;
        }
        else
        {
            Log.e("CreateFolder_function", "Folder Created At :" + folder.getPath().toString() ) ;
        }
        return folder.getPath().toString();
    }

    public static Boolean checkExist(String filePath){

        File file = new File(filePath);

        Log.e("checkExist_Function",file.getPath().toString()) ;

        if(file.exists()) {
            Log.e("checkExist_Function","true") ;
            return true;
        }

        return false ;
    }

    public static String path(String file_name){

        File file = new File(Environment.getExternalStorageDirectory().toString()+"/Android/data/" + PACKAGE_NAME +"/UserGuide/"+file_name);

        Log.e("path_function",file.getPath().toString()) ;

        return file.getPath().toString();
    }

}
