package com.example.androidregimen;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.lzyzsd.circleprogress.DonutProgress;

import java.util.ArrayList;

public class DetailsPage extends AppCompatActivity {

    TextView name;
    TextView everyday;
    TextView time;
    ImageButton completedTask;
    Button btnBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details_page);

        TinyDB tinydb = new TinyDB(this);

        DonutProgress donutProgress = findViewById(R.id.progressBar);
        name = findViewById(R.id.griddata);
        everyday = findViewById(R.id.textEveryday);
        time = findViewById(R.id.textTotalTime);
        completedTask = findViewById(R.id.btnFinished);
        btnBack = findViewById(R.id.btnBack);

        Intent intent = getIntent();
        String str = intent.getStringExtra("status");
        Processor temp = new Processor(str);
        donutProgress.setDonut_progress(temp.getPercentage());
        name.setText(temp.getTitle());
        time.setText("Time: " + temp.getTime());
        if (temp.isTimeBased()) {
            System.out.println("YES");
            time.setVisibility(View.VISIBLE);
        }
        else {
            time.setVisibility(View.INVISIBLE);
            System.out.println("NO");
        }
        if (temp.getIsEqualEveryday()){
            everyday.setVisibility(View.VISIBLE);
        }
        else{
            everyday.setVisibility(View.INVISIBLE);
        }

        btnBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        completedTask.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ArrayList<String> gridList = tinydb.getListString("list");
                // Title | Percentage | Type | Everyday | Time
                String data = temp.getTitle() + "," + "100," + temp.getType() + "," + temp.getEveryday() + "," + temp.getTime();
                gridList.set(gridList.indexOf(str), data);
                tinydb.putListString("list", gridList);
                finish();
            }
        });
    }
}