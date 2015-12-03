package com.example.andrewlinenfelser.coffee;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class RecieveCoffeeActivity extends AppCompatActivity {

    private String brewery;
    private String breweryURL;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recieve_coffee);

        //get intent
        Intent intent = getIntent();
        brewery = intent.getStringExtra("breweryName");
        breweryURL = intent.getStringExtra("breweryURL");
        System.out.println("______WORKING_____");
        System.out.println(brewery);
        System.out.println(breweryURL);

        //update text view
        TextView messageView = (TextView) findViewById(R.id.coffeeShopTextView);
        messageView.setText("You should check out " + brewery);
    }

    public void loadWebSite(View view){
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(breweryURL));
        startActivity(intent);

    }
}
