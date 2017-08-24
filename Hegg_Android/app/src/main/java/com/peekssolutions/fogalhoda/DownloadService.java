package com.peekssolutions.fogalhoda;

import android.app.IntentService;
import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;

import com.androidnetworking.AndroidNetworking;
import com.androidnetworking.common.Priority;
import com.androidnetworking.error.ANError;
import com.androidnetworking.interfaces.DownloadListener;
import com.androidnetworking.interfaces.DownloadProgressListener;
import com.peekssolutions.fogalhoda.activity.UserGuideActivity;
import com.peekssolutions.fogalhoda.model.Download;

/**
 * An {@link IntentService} subclass for handling asynchronous task requests in
 * a service on a separate handler thread.
 * <p>
 * TODO: Customize class - update intent actions, extra parameters and static
 * helper methods.
 */
public class DownloadService extends IntentService {

    String fileName="" ;
    String url="";
    int adapterPosition=0 ;

    /**
     * Creates an IntentService.  Invoked by your subclass's constructor.
     *
     */
    public DownloadService() {
        super("Download Service");
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        fileName=intent.getStringExtra("File_Name");
        url=intent.getStringExtra("File_Link") ;
        adapterPosition=intent.getIntExtra("File_Position",0);
        initDownload();
    }

    private void initDownload(){

        Hegg.createPackageFolder();
        Hegg.createFolder();
        DownloadFile();
    }

    void DownloadFile(){
        Log.e("URL",url);
        Log.e("File_name",fileName);
        AndroidNetworking.download(url,Hegg.createFolder(),fileName)
                .setTag("downloadTest")
                .setPriority(Priority.HIGH)
                .build()
                .setDownloadProgressListener(new DownloadProgressListener() {
                    @Override
                    public void onProgress(long bytesDownloaded, long totalBytes) {
                        // do anything with progress
                    //    Log.e("TAG",String.valueOf((bytesDownloaded/totalBytes)*100)) ;
                        Log.e("TAG",String.valueOf(Double.valueOf((bytesDownloaded/totalBytes)*100.0)));
                    }
                })
                .startDownload(new DownloadListener() {
                    @Override
                    public void onDownloadComplete() {
                        // do anything after completion
                        Log.e("TAG","Download Complete") ;
                        onDownloadFinish();
                    }
                    @Override
                    public void onError(ANError error) {
                        // handle error
                        Log.e("TAG","Download Error") ;

                    }
                });
    }

    private void sendIntent(Download download){

        Intent intent = new Intent(UserGuideActivity.MESSAGE_PROGRESS);
        intent.putExtra("download",download);
        intent.putExtra("File_Name",fileName);
        intent.putExtra("position",adapterPosition) ;
        Log.e("Service",fileName) ;
        Log.e("Service",fileName) ;

        LocalBroadcastManager.getInstance(DownloadService.this).sendBroadcast(intent);
    }

    private void onDownloadFinish(){
        Download download = new Download();
        download.setProgress(100);
        sendIntent(download);
    }



}
