package com.example.androidregimen;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.GridLayout;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

import java.io.*;
import java.util.Set;

public class HomePage extends AppCompatActivity {

    GridView gridView;
    Button btnDelete;
    Button btnEdit;
    ImageButton btnAdd;
    ArrayList<String> fruitNames = new ArrayList<>(Arrays.asList("Apple", "Orange", "Strawberry", "Watermelon", "Kiwi", "Banana"));
//    int[] fruitImages = {R.drawable.apple, R.drawable.oranges, R.drawable.strawberry,
//            R.drawable.watermelon, R.drawable.kiwi, R.drawable.banana};

    public static final String SHARED_PREFS = "sharedPrefs";
    public static final String LIST = "list";

    public ArrayList<String> gridList = new ArrayList<String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_page);

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
                Intent intent = new Intent(getApplicationContext(), DetailsPage.class);
                intent.putExtra("name", fruitNames.get(position));
//                intent.putExtra("image", fruitImages[position]);
                startActivity(intent);
            }
        });

        btnEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gridList.add("Hello");
                saveData();
                System.out.println(gridList);
            }
        });

        btnDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gridList.remove(0);
                saveData();
                System.out.println(gridList);
                CustomAdapter customAdapter = new CustomAdapter();
                gridView.setAdapter(customAdapter);
                setGridViewHeightBasedOnChildren(gridView, 2);
            }
        });

        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(v.getContext(), AddTaskPage.class);
                startActivity(intent);
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
//            ImageView image = view1.findViewById(R.id.images);

            name.setText(gridList.get(position));
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
    }

    private void loadData(){
        TinyDB tinydb = new TinyDB(this);
        gridList = tinydb.getListString(LIST);
    }
}