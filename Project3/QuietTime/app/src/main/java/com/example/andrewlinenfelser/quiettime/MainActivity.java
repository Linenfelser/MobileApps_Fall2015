package com.example.andrewlinenfelser.quiettime;

import android.content.Context;
import android.media.AudioManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextClock;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import java.lang.reflect.Array;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;
import java.util.logging.Handler;
import java.util.logging.LogRecord;


public class MainActivity extends AppCompatActivity {

    AudioManager changeRinger;

    Date date = new Date();
    String dateString = date.toString();
    String [] dateSplit  = dateString.split(" ");
    String [] timeSplit = dateSplit[3].split(":");
    ArrayList<String> addArray = new ArrayList<>();

    ArrayList <Integer> cmpTimesArrayHour = new ArrayList<>();
    ArrayList <Integer> cmpTimesArrayMinute = new ArrayList<>();
    ArrayAdapter<String> adapter;

    /* currently updating every 6 seconds until top of the hour
    * will then update based on the smallest minute input
    * For Example: input 1:15 will have the app update every 15 minutes*/
    int timerDelay = 6000; //3600000 milliseconds = 1 hr | 60000 milliseconds = 1 minute
//    int updateMinute;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        changeRinger = (AudioManager)getSystemService(Context.AUDIO_SERVICE);

        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        updateTime();
                    }
                });
            }
        }, 0, timerDelay);

    }

    public void addTime(View view){

            ListView listViewTimes = (ListView) findViewById(R.id.listViewTimes);
            EditText editTextStart = (EditText) findViewById(R.id.editTextStart);
            EditText editTextEnd = (EditText) findViewById(R.id.editTextEnd);


            if(editTextStart.getText().toString().trim().length() != 0 && editTextEnd.getText().toString().trim().length() != 0) {
                if (editTextStart.getText().toString().contains("-") && editTextEnd.getText().toString().contains("-")){


                    String inputTimeStringStart = editTextStart.getText().toString();
                    String[] inputTimeStart = inputTimeStringStart.split("-");

                    String inputTimeStringEnd = editTextEnd.getText().toString();
                    String[] inputTimeEnd = inputTimeStringEnd.split("-");

                    //check if hours are in range
                    if((Integer.parseInt(inputTimeStart[0]) == 0 || Integer.parseInt(inputTimeStart[0]) > 24)){
                        editTextStart.setError("Not an Acceptable Time for Hour");
                    }
                    else if((Integer.parseInt(inputTimeEnd[0]) == 0 || Integer.parseInt(inputTimeEnd[0]) > 24)){
                        editTextEnd.setError("Not an Acceptable Time for Hour");
                    }

                    //check if minutes are in range
                    else if((Integer.parseInt(inputTimeStart[1]) > 59)){
                        editTextStart.setError("Not an Acceptable Time for Minute");
                    }
                    else if((Integer.parseInt(inputTimeEnd[1]) > 59)){
                        editTextEnd.setError("Not an Acceptable Time for Minute");
                    }
                    //if both hours and minutes are acceptable, continue
                    else {

                        cmpTimesArrayHour.add(Integer.parseInt(inputTimeStart[0]));
                        cmpTimesArrayHour.add(Integer.parseInt(inputTimeEnd[0]));
                        cmpTimesArrayMinute.add(Integer.parseInt(inputTimeStart[1]));
                        cmpTimesArrayMinute.add(Integer.parseInt(inputTimeEnd[1]));


                        adapter = new ArrayAdapter<>(this, android.R.layout.simple_expandable_list_item_1, addArray);
                        listViewTimes.setAdapter(adapter);
                        addArray.add(editTextStart.getText().toString() + " to " + editTextEnd.getText().toString());

                        updateTime();

                        //clear the text fields
                        editTextStart.setText("");
                        editTextEnd.setText("");
                    }
                }
                else if (!editTextStart.getText().toString().contains("-") && !editTextEnd.getText().toString().contains("-")){
                    editTextStart.setError("Not Correct Format");
                    editTextEnd.setError("Not Correct Format");
                }
                else if(!editTextStart.getText().toString().contains("-")){
                    editTextStart.setError("Not Correct Format");
                }
                else if(!editTextEnd.getText().toString().contains("-")){
                    editTextEnd.setError("Not Correct Format");
                }


            }
            else if(editTextStart.getText().toString().trim().length() == 0 && editTextEnd.getText().toString().trim().length() == 0){
                editTextStart.setError("Starting Time Required");
                editTextEnd.setError("Ending Time Required");
            }
            else if (editTextStart.getText().toString().trim().length() == 0) {
                    editTextStart.setError("Starting Time Required");
            }
            else if (editTextEnd.getText().toString().trim().length() == 0) {
                editTextEnd.setError("Ending Time Required");
            }
    }



    public void updateTime(){
        Date date = new Date();
        String dateString = date.toString();
        String [] dateSplit  = dateString.split(" ");
        String [] timeSplit = dateSplit[3].split(":");

        TextView display = (TextView) findViewById(R.id.textViewDisplay);

        System.out.println("_________TIMESPLIT[1]__________:" + timeSplit[1]);

        //set timer delay to smallest minute input
        //check every minute until minutes == 0 then update timer so it will be synced
        if(Integer.parseInt(timeSplit[1]) == 0){
            for(int i=0; i<cmpTimesArrayMinute.size(); i++){
                if(cmpTimesArrayMinute.get(i) !=0 && cmpTimesArrayMinute.get(i)*60000 < timerDelay){
                    timerDelay = cmpTimesArrayMinute.get(i)*60000;
                }
            }
        }

        System.out.println("_________TIMER_________:" + timerDelay);

        /*timeSplit[0] = hour
         * timeSplit[1] = minutes
          * timeSplit[3] = seconds
          *     TIME IS IN 24 HOUR*/

        EditText editTextStart = (EditText) findViewById(R.id.editTextStart);
        EditText editTextEnd = (EditText) findViewById(R.id.editTextEnd);

        if(cmpTimesArrayHour.size() != 0) {

//            if (editTextStart.getText().toString().trim().length() != 0 && editTextEnd.getText().toString().trim().length() != 0) {

                int actualTimeHour = Integer.parseInt(timeSplit[0]);
                int actualTimeMinute = Integer.parseInt(timeSplit[1]);

                for (int i = 0; i < cmpTimesArrayHour.size(); i++) {
                    if (i % 2 == 0) { //if an even number (start)
                        System.out.println("cmpTimesArrayHour[i]: " + cmpTimesArrayHour.get(i));
                        System.out.println("cmpTimesArrayHour[i+1]: " + cmpTimesArrayHour.get(i + 1));
                        System.out.println("cmpTimesArrayMinute[i]: " + cmpTimesArrayMinute.get(i));
                        System.out.println("cmpTimesArrayMinute[i+1]: " + cmpTimesArrayMinute.get(i + 1));
                        System.out.println("actualTimeHour: " + actualTimeHour);
                        System.out.println("actualTimeMinute: " + actualTimeMinute);

                        //if =inputHourStart is less than actualHour and inputHourEnd is greater, quietTime
                        if (cmpTimesArrayHour.get(i) < actualTimeHour && cmpTimesArrayHour.get(i + 1) > actualTimeHour) {
                            changeRinger.setRingerMode(AudioManager.RINGER_MODE_VIBRATE);
                            System.out.println("____TIME_TO_BE_QUIET____" + cmpTimesArrayHour);
                            System.out.println(actualTimeHour);
                            display.setText("Quiet Time On");
                            break;
                        }
                        //comparing hours
                        if (cmpTimesArrayHour.get(i) > actualTimeHour && cmpTimesArrayHour.get(i + 1) < actualTimeHour) {
                            changeRinger.setRingerMode(AudioManager.RINGER_MODE_NORMAL);
                            System.out.println("___NOT_QUIET_TIME___" + cmpTimesArrayHour);
                            display.setText("Quiet Time Off");
                        }

                        if (cmpTimesArrayHour.get(i) == actualTimeHour && cmpTimesArrayHour.get(i + 1) == actualTimeHour) {
                            if (actualTimeMinute >= cmpTimesArrayMinute.get(i) && actualTimeMinute <= cmpTimesArrayMinute.get(i + 1)) {
                                changeRinger.setRingerMode(AudioManager.RINGER_MODE_VIBRATE);
                                System.out.println("____TIME_TO_BE_QUIET____" + cmpTimesArrayHour);
                                display.setText("Quiet Time On");
                                break;
                            } else {
                                changeRinger.setRingerMode(AudioManager.RINGER_MODE_NORMAL);
                                System.out.println("___NOT_QUIET_TIME___" + cmpTimesArrayHour);
                                display.setText("Quiet Time Off");
                            }
                        }
                        if (cmpTimesArrayHour.get(i) == actualTimeHour && cmpTimesArrayHour.get(i + 1) > actualTimeHour) {
                            if (actualTimeMinute >= cmpTimesArrayMinute.get(i)) {
                                changeRinger.setRingerMode(AudioManager.RINGER_MODE_VIBRATE);
                                System.out.println("____TIME_TO_BE_QUIET____" + cmpTimesArrayHour);
                                display.setText("Quiet Time On");
                                break;
                            } else {
                                changeRinger.setRingerMode(AudioManager.RINGER_MODE_NORMAL);
                                System.out.println("___NOT_QUIET_TIME___" + cmpTimesArrayHour);
                                display.setText("Quiet Time Off");
                            }
                        }

                        if (cmpTimesArrayHour.get(i) < actualTimeHour && cmpTimesArrayHour.get(i + 1) == actualTimeHour) {
                            if (actualTimeMinute <= cmpTimesArrayMinute.get(i + 1)) {
                                changeRinger.setRingerMode(AudioManager.RINGER_MODE_VIBRATE);
                                System.out.println("____TIME_TO_BE_QUIET____" + cmpTimesArrayHour);
                                display.setText("Quiet Time On");
                                break;
                            } else {
                                changeRinger.setRingerMode(AudioManager.RINGER_MODE_NORMAL);
                                System.out.println("___NOT_QUIET_TIME___" + cmpTimesArrayHour);
                                display.setText("Quiet Time Off");
                            }
                        } else {
                            changeRinger.setRingerMode(AudioManager.RINGER_MODE_NORMAL);
                            System.out.println("___NOT_QUIET_TIME___" + cmpTimesArrayHour);
                            display.setText("Quiet Time Off");
                        }
                    } else { //odd number (check end time)
                        System.out.println("__i%2 != 0__");
                    }

                }

            }
//        }
        else {
            System.out.println("STARTING_TIME_REQUIRED");
//            editTextStart.setError("Starting Time Required");
//            editTextEnd.setError("Ending Time Required");
        }
    }
}