package com.example.andrewlinenfelser.quiettime;

import android.content.Context;
import android.media.AudioManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextClock;
import android.widget.TextView;
import android.widget.Toast;

import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;


public class MainActivity extends AppCompatActivity {

    AudioManager changeRinger;
    Button buttonAdd;
//    int timeTestStart = 3;
//    int timeTestEnd = 5;

//    Time currentTime = new Time();
    Date date = new Date();
    String dateString = date.toString();
    String [] dateSplit  = dateString.split(" ");
    String [] timeSplit = dateSplit[3].split(":");


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        changeRinger = (AudioManager)getSystemService(Context.AUDIO_SERVICE);
        System.out.println("____IN_MAIN_ACTIVITY____");
        System.out.println(date);
        System.out.println("____dateSplit[3]____");
        System.out.println(dateSplit[3]);
        System.out.println("____timeSplit[0]____");
        System.out.println(timeSplit[0]);
        System.out.println("____timeSplit[1]____");
        System.out.println(timeSplit[1]);
        System.out.println("____timeSplit[2]____");
        System.out.println(timeSplit[2]);


    }


    public void addTime(View view){


        //    ArrayList<String> addArray = new ArrayList<>();
        EditText editTextStart = (EditText) findViewById(R.id.editTextStart);
        EditText editTextEnd = (EditText) findViewById(R.id.editTextEnd);

        TextView timeText = (TextView) findViewById(R.id.timeText);
        timeText.setText(editTextStart.getText().toString());

        int startTime = Integer.parseInt(editTextStart.getText().toString());
        int endTime = Integer.parseInt(editTextEnd.getText().toString());
        //int currentTime = TextClock;

        int actualTimeHour = Integer.parseInt(timeSplit[0]);

        /*need to get time slot to be able to overlap
        * create an array? or dictionary? with all of the users desired times to be quiet
        *timeSplit[0] = hour
         * timeSplit[1] = minutes
          * timeSplit[3] = seconds
          *     TIME IS IN 24 HOUR*/


        if (startTime >= actualTimeHour && endTime <= actualTimeHour){
           changeRinger.setRingerMode(AudioManager.RINGER_MODE_VIBRATE);
            System.out.println("____TIME_TO_BE_QUIET____");
            System.out.println(actualTimeHour);

        }

        else{
            changeRinger.setRingerMode(AudioManager.RINGER_MODE_NORMAL);
            System.out.println("___NOT_TIME_TO_BE_QUIET");
        }


//        Button buttonAdd;
//        Map<Integer,Integer> timeMap = new HashMap<>();

//        addArray.set(0,editTextStart.getText().toString());
//        addArray.set(1,editTextEnd.getText().toString());

    }

}
