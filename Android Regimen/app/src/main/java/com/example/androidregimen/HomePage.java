package com.example.androidregimen;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.Image;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.GridLayout;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.github.lzyzsd.circleprogress.DonutProgress;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

import java.io.*;
import java.util.Set;

class Processor {
    String item;
  // Title | Percentage | Type | Everyday | Time
     String Title;
     String Percentage;
     String Type;
     String Everyday;
     String Time;

    public Processor(String s) {
        item = s;
        String[] spt = item.split("[,]");
        Title = spt[0];
        Percentage = spt[1];
        Type = spt[2];
        Everyday = spt[3];
        Time = spt[4];
    }

    public String getTitle() {
        return Title;
    }

    public String getPercentage() {
        return Percentage;
    }

    public String getEveryday() {
        return Everyday;
    }

    public String getItem() {
        return item;
    }

    public String getTime() {
        return Time;
    }

    public String getType() {
        return Type;
    }
}

public class HomePage extends AppCompatActivity {

    GridView gridView;
    Button btnDelete;
    Button btnEdit;
    ImageButton btnAdd;
    ArrayList<String> delList = new ArrayList<String>();

    boolean editMode = false;

    public static final String LIST = "list";

    public ArrayList<String> gridList = new ArrayList<String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_page);



        ActivityResultLauncher<Intent> someActivityResultLauncher = registerForActivityResult(
                new ActivityResultContracts.StartActivityForResult(),
                new ActivityResultCallback<ActivityResult>() {
                    @Override
                    public void onActivityResult(ActivityResult result) {
                        loadData();
                        refreshGrid();
                    }
                });

        loadData();

        btnDelete = (Button)findViewById(R.id.btnDelete);
        btnEdit = (Button)findViewById(R.id.btnEdit);
        btnAdd = (ImageButton) findViewById(R.id.btnAdd);

        gridView = findViewById(R.id.gridView);

        CustomAdapter customAdapter = new CustomAdapter();
        gridView.setAdapter(customAdapter);

        setGridViewHeightBasedOnChildren(gridView, 2);

        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                if(editMode){
                    ImageView check = view.findViewById(R.id.selectCheckbox);
                    if (delList.contains(String.valueOf(position))){
                        check.setVisibility(View.INVISIBLE);
                        delList.remove(String.valueOf(position));
                    }
                    else {
                        check.setVisibility(View.VISIBLE);

                        delList.add(String.valueOf(position));
                    }
                }
                else {

                    Intent intent = new Intent(getApplicationContext(), DetailsPage.class);
                    Processor temp = new Processor(gridList.get(position));
                    intent.putExtra("name", temp.getTitle());
                    startActivity(intent);
                }
            }
        });

        btnEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(editMode) {
                    for(int i = 0; i < gridView.getChildCount(); i++) {
                        ImageView check = gridView.getChildAt(i).findViewById(R.id.selectCheckbox);
                        check.setVisibility(View.INVISIBLE);
                    }
                    btnEdit.setText("Edit");
                    editMode = false;

                }
                else{
                    btnEdit.setText("Done");
                    editMode = true;
                }
            }
        });

        btnDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(delList.size() != 0 && editMode){
                    for(String i : delList) {
                        gridList.remove(Integer.parseInt(i));
                    }
                    refreshGrid();
                    saveData();
                    delList = new ArrayList<String>();
                }
            }
        });

        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                saveData();
                Intent intent = new Intent(v.getContext(), AddTaskPage.class);
                someActivityResultLauncher.launch(intent);
            }
        });
    }
    private class CustomAdapter extends BaseAdapter{

        @Override
        public int getCount() {
            return gridList.size();
        }

        @Override
        public Object getItem(int position) {
            return null;
        }

        @Override
        public long getItemId(int position) {
            return 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View view1 = getLayoutInflater().inflate(R.layout.row_data, null);

            TextView name = view1.findViewById(R.id.fruits);
            DonutProgress donutProgress = view1.findViewById(R.id.progress);
//            ImageView image = view1.findViewById(R.id.images);
            if (gridList.size() != 0) {
                Processor temp = new Processor(gridList.get(position));
                name.setText(temp.getTitle());
                donutProgress.setDonut_progress(temp.getPercentage());
            }
//            image.setImageResource(fruitImages[position]);
            return view1;
        }
    }

    private void setGridViewHeightBasedOnChildren(GridView gridView, int noOfColumns) {
        ListAdapter gridViewAdapter = gridView.getAdapter();
        if (gridViewAdapter == null) {
            // adapter is not set yet
            return;
        }

        int totalHeight; //total height to set on grid view
        int items = gridViewAdapter.getCount(); //no. of items in the grid
        int rows; //no. of rows in grid
        if (items > 0) {
            View listItem = gridViewAdapter.getView(0, null, gridView);
            listItem.measure(0, 0);
            totalHeight = listItem.getMeasuredHeight();

            float x;
            if (items > noOfColumns) {
                x = items / noOfColumns;

                //Check if exact no. of rows of rows are available, if not adding 1 extra row
                if (items % noOfColumns != 0) {
                    rows = (int) (x + 1);
                } else {
                    rows = (int) (x);
                }
                totalHeight *= rows;

                //Adding any vertical space set on grid view
                totalHeight += gridView.getVerticalSpacing() * rows;
            }

            //Setting height on grid view
            ViewGroup.LayoutParams params = gridView.getLayoutParams();
            params.height = totalHeight;
            gridView.setLayoutParams(params);
        }
        else{
            ViewGroup.LayoutParams params = gridView.getLayoutParams();
            params.height = 0;
            gridView.setLayoutParams(params);
        }
    }

    private void saveData(){
        TinyDB tinydb = new TinyDB(this);
        tinydb.putListString(LIST, gridList);
        System.out.println(gridList);
    }

    private void loadData(){
        TinyDB tinydb = new TinyDB(this);
        gridList = tinydb.getListString(LIST);
        System.out.println(gridList);
    }

    public void refreshGrid(){
        CustomAdapter customAdapter = new CustomAdapter();
        gridView.setAdapter(customAdapter);
        setGridViewHeightBasedOnChildren(gridView, 2);
    }

    public void createItem(String title, String type, String everyday, String time){
        gridList.add(title + "," + "0," + type + "," + everyday + "," + time);
        // Title | Percentage | Type | Everyday | Time
    }


}