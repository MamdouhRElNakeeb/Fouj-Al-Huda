package com.peekssolutions.fogalhoda.activity;

import android.app.ProgressDialog;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.Toast;

import com.peekssolutions.fogalhoda.R;
import com.necistudio.vigerpdf.VigerPDF;
import com.necistudio.vigerpdf.adapter.VigerAdapter;
import com.necistudio.vigerpdf.manage.OnResultListener;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ReadPdfActivity extends AppCompatActivity {
    @BindView(R.id.viewPager)
     ViewPager viewPager;
    private ArrayList<Bitmap> itemData;
    private VigerAdapter adapter;
    private VigerPDF vigerPDF;
    ProgressDialog progressDialog ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_read_pdf);
        ButterKnife.bind(this);
        vigerPDF = new VigerPDF(this);
        itemData = new ArrayList<>();
        adapter = new VigerAdapter(getApplicationContext(), itemData);
        viewPager.setAdapter(adapter);


        if(getIntent().getExtras() != null){
            /*Log.e("TAG","READ");
            Log.e("TAG",getIntent().getStringExtra("file_path"));
            String file_path=getIntent().getStringExtra("file_path");
            File file=new File(file_path);*/
            String url=getIntent().getStringExtra("URL");
            Log.e("TAG",url);
            fromNetwork(url);
            initProgress();
        }
    }

    private void initProgress() {
        progressDialog = new ProgressDialog(ReadPdfActivity.this);
        progressDialog.setMessage("من فضلك انتظر...");
        progressDialog.setTitle("جارى تحميل الكتاب");
        progressDialog.show();
    }

    private void fromNetwork(String endpoint) {
        itemData.clear();
        adapter.notifyDataSetChanged();
        vigerPDF.cancle();
        vigerPDF.initFromNetwork(endpoint, new OnResultListener() {
            @Override
            public void resultData(Bitmap data) {
                Log.e("data", "run");
                itemData.add(data);
                adapter.notifyDataSetChanged();
            }

            @Override
            public void progressData(int progress) {
                Log.e("data", "" + progress);
                if(progress==100)
                {
                    progressDialog.dismiss();
                }
            }

            @Override
            public void failed(Throwable t) {
                    Log.e("ERROR",t.toString());
                    progressDialog.dismiss();
                Toast.makeText(ReadPdfActivity.this,t.toString(),Toast.LENGTH_LONG).show();
            }

        });
    }


}
