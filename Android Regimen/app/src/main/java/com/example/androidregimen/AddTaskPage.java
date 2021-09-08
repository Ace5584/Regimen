package com.example.androidregimen;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

import java.util.ArrayList;

public class AddTaskPage extends AppCompatActivity {
    EditText editTitle;
    EditText editTime;
    CheckBox checkBoxEveryday;
    ImageButton btnComplete;
    RadioGroup radioGroup;
    RadioButton radioButton;
    LinearLayout timeLayout;

    ArrayList<String> gridList = new ArrayList<String>();
    public static final String LIST = "list";

    Boolean TimeBased = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_task_page);

        loadData();

        radioGroup = findViewById(R.id.taskRadioGroup);
        editTitle = findViewById(R.id.taskTitle);
        editTime = findViewById(R.id.editTime);
        checkBoxEveryday = findViewById(R.id.checkboxEveryday);
        btnComplete = findViewById(R.id.btnFinished);

        btnComplete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (TimeBased){
                    if (editTitle.getText().toString() != "" && editTime.getText().toString() != ""){
                        String check = "false";
                        if(checkBoxEveryday.isChecked())
                            check = "true";
                        createItem(editTitle.getText().toString(), "Time Based", check,
                                editTime.getText().toString());
                        saveData();
                        finish();
                    }
                }
                else {
                    String check = "false";
                    if(checkBoxEveryday.isChecked())
                        check = "true";
                    createItem(editTitle.getText().toString(), "Time Based", check, "0");
                    saveData();

                    finish();
                }
            }
        });

    }

    public void checkButton(View v){
        int radioId = radioGroup.getCheckedRadioButtonId();

        radioButton = findViewById(radioId);

        Toast.makeText(this, "Selected Radio Button: " + radioButton.getText(), Toast.LENGTH_SHORT).show();

        timeLayout = findViewById(R.id.timeLayout);

        if(radioButton.getId() == R.id.radioTimeBased) {
            timeLayout.setVisibility(View.VISIBLE);
            TimeBased = true;
        }
        else {
            timeLayout.setVisibility(View.INVISIBLE);
            TimeBased = false;
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

    public void createItem(String title, String type, String everyday, String time){
        gridList.add(title + "," + "0," + type + "," + everyday + "," + time);
        // Title | Percentage | Type | Everyday | Time
    }
}