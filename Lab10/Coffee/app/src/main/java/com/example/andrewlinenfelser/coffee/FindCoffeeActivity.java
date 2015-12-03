package com.example.andrewlinenfelser.coffee;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Spinner;
import android.content.Intent;

public class FindCoffeeActivity extends AppCompatActivity {

    private Brewery myBrewery = new Brewery();
    public void findBrewery(View view){
        Spinner crowdSpinner = (Spinner)findViewById(R.id.spinner);
        String crowd = String.valueOf(crowdSpinner.getSelectedItem());
        myBrewery.setBreweryName(crowd);
        String suggestedBrewery = myBrewery.getBreweryName();
        String suggestedBreweryURL = myBrewery.getBreweryURL();
        System.out.println(suggestedBrewery);
        System.out.println(suggestedBreweryURL);

        //create an intent
        Intent intent = new Intent(this, RecieveCoffeeActivity.class);

        //pass data
        intent.putExtra("breweryName", suggestedBrewery);
        intent.putExtra("breweryURL", suggestedBreweryURL);

        //start the intent
        startActivity(intent);

    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_find_coffee);
    }
}
