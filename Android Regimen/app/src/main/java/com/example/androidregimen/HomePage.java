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

// Custom class that processes the item in the gridList
class Processor {
    String item;
  // Title | Percentage | Type | Everyday | Time
     String Title;
     String Percentage;
     String Type;
     String Everyday;
     String Time;

     // this initalizer splits the string into pieces of usable data
    public Processor(String s) {
        item = s;
        String[] spt = item.split("[,]");
        Title = spt[0];
        Percentage = spt[1];
        Type = spt[2];
        Everyday = spt[3];
        Time = spt[4];
    }

    // Returns the title
    public String getTitle() {
        return Title;
    }

    // Returns the percentage
    public String getPercentage() {
        return Percentage;
    }

    // Returns whether the task is everyday or not in a boolean
    public boolean getIsEqualEveryday() {
        return Everyday.equals("true");
    }

    // Returns the everyday string
    public String getEveryday() {
        return Everyday;
    }

    // Returns the original string
    public String getItem() {
        return item;
    }

    // Returns the time as string
    public String getTime() {
        return Time;
    }

    // Return whether the task is time based or not
    public boolean isTimeBased() {
        return Type.equals("Time Based");
    }

    // Return the type of the task
    public String getType() {
        return Type;
    }
}

public class HomePage extends AppCompatActivity {

    // initialize all the variables
    GridView gridView;
    Button btnDelete;
    Button btnEdit;
    ImageButton btnAdd;
    ArrayList<String> delList = new ArrayList<String>();

    // Boolean value that determains whether the grid is in edit mode
    boolean editMode = false;

    // A public static string that contains the key for storing data for gridList
    public static final String LIST = "list";

    // This is a arraylist containing all the items in for the grid view
    public ArrayList<String> gridList = new ArrayList<String>();

    // On create function runs when the app is launched
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_page);


        // This is an activity launcher and have custom functions when the certain activity
        // is completed. It loads the data and refreshes the grid when the activity is done
        ActivityResultLauncher<Intent> someActivityResultLauncher = registerForActivityResult(
                new ActivityResultContracts.StartActivityForResult(),
                new ActivityResultCallback<ActivityResult>() {
                    @Override
                    public void onActivityResult(ActivityResult result) {
                        loadData();
                        refreshGrid();
                    }
                });

        // Loads the data from storage to the gridList
        loadData();

        // assigning value and start all the buttons and grid views
        btnDelete = (Button)findViewById(R.id.btnDelete);
        btnEdit = (Button)findViewById(R.id.btnEdit);
        btnAdd = (ImageButton) findViewById(R.id.btnAdd);
        gridView = findViewById(R.id.gridView);
        CustomAdapter customAdapter = new CustomAdapter();
        gridView.setAdapter(customAdapter);
        setGridViewHeightBasedOnChildren(gridView, 2);

        // this function pulls up a new view controller when clicked with the details of the
        // specific tasks. this is set on all the grids in the grid view
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
                    intent.putExtra("status", gridList.get(position));
                    someActivityResultLauncher.launch(intent);
                }
            }
        });

        // This button lets the grid view become editable and changes the text from Edit to Done
        // when completed editing
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

        // this button deletes the item on the grid if the conditions are met
        // (Box checked && in edit mode)
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

        // This button launches the add task page when clicked and saves the data before launching
        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                saveData();
                Intent intent = new Intent(v.getContext(), AddTaskPage.class);
                someActivityResultLauncher.launch(intent);
            }
        });
    }

    // This calss contains the custom adapter for the grid view
    private class CustomAdapter extends BaseAdapter{

        // returns the count of the grids in the gridview
        @Override
        public int getCount() {
            return gridList.size();
        }

        // auto generated override
        @Override
        public Object getItem(int position) {
            return null;
        }

        // auto generated override
        @Override
        public long getItemId(int position) {
            return 0;
        }

        // This function creates the boxes for each section of the grid view and returns
        // the an entire view
        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View view1 = getLayoutInflater().inflate(R.layout.row_data, null);

            TextView name = view1.findViewById(R.id.fruits);
            DonutProgress donutProgress = view1.findViewById(R.id.progress);
            if (gridList.size() != 0) {
                Processor temp = new Processor(gridList.get(position));
                name.setText(temp.getTitle());
                donutProgress.setDonut_progress(temp.getPercentage());
            }
            return view1;
        }
    }

    // This function sets the grid view height by the amount of columns
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

    // This function saves the data into the device using a custom class TinyDB
    private void saveData(){
        TinyDB tinydb = new TinyDB(this);
        tinydb.putListString(LIST, gridList);
        System.out.println(gridList);
    }

    // THis function loads the data from the system using TinyDB
    private void loadData(){
        TinyDB tinydb = new TinyDB(this);
        gridList = tinydb.getListString(LIST);
        System.out.println(gridList);
    }

    // This function refreshes the grid when something is modified on the grid
    public void refreshGrid(){
        CustomAdapter customAdapter = new CustomAdapter();
        gridView.setAdapter(customAdapter);
        setGridViewHeightBasedOnChildren(gridView, 2);
    }
}