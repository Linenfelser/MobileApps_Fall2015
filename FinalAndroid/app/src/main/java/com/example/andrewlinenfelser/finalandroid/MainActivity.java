package com.example.andrewlinenfelser.finalandroid;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.ToggleButton;

import java.util.jar.Attributes;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }


    public void findPizza(View view){
        TextView pizzaDisplay = (TextView) findViewById(R.id.displayPizza);

        Spinner sizeSPinner = (Spinner) findViewById(R.id.spinner);
        String spinnerValue = String.valueOf(sizeSPinner.getSelectedItem());

        EditText name = (EditText) findViewById(R.id.name_editText);
        String NameValue = name.getText().toString();

        ToggleButton toggle = (ToggleButton) findViewById(R.id.sauceToggle);
        boolean sauce = toggle.isChecked();
        String sauceString;
        if(sauce){
            sauceString = "red";
        }
        else{
            sauceString = "white";
        }

        RadioGroup crust = (RadioGroup) findViewById(R.id.crust_type);
        String crustString = " ";

        int crust_id = crust.getCheckedRadioButtonId();
        switch(crust_id){
            case -1:
                crustString = "no";
                break;
            case R.id.radioButton1:
                crustString = "Thick";
                break;
            case R.id.radioButton2:
                crustString = "Thin";
                break;
            case R.id.radioButton3:
                crustString = "Deep Dish";
                break;
            default:
                crustString = "no";
        }

        String checkbox_string = " ";
        CheckBox check1 = (CheckBox) findViewById(R.id.checkBox1);
        boolean checked1 = check1.isChecked();
        if(checked1){
            checkbox_string += "pepperoni, ";
        }

        CheckBox check2 = (CheckBox) findViewById(R.id.checkBox2);
        boolean checked2 = check2.isChecked();
        if(checked2){
            checkbox_string += "jalapenos, ";
        }

        CheckBox check3 = (CheckBox) findViewById(R.id.checkBox3);
        boolean checked3 = check3.isChecked();
        if(checked3){
            checkbox_string += "bacon, ";
        }

        CheckBox check4 = (CheckBox) findViewById(R.id.checkBox4);
        boolean checked4 = check4.isChecked();
        if(checked4){
            checkbox_string += "canadian bacon";
        }

        String glutenString = " ";
        Switch gluten_switch = (Switch) findViewById(R.id.switch1);
        boolean gluten = gluten_switch.isChecked();
        if(gluten){
            glutenString = "and is gluten free";
        }


        pizzaDisplay.setText(NameValue + " is a pizza with " + sauceString +  " sauce and with " + crustString + " crust " +
                " with " + checkbox_string + " for toppings " + glutenString);

        ImageView p = (ImageView) findViewById(R.id.imageView);
        int image;
        if (checkbox_string.equals(" ")) {
            image = R.drawable.pizza_cheese;
        } else if (crustString.equals("Thin")) {
            image = R.drawable.pizza_veggie;
        } else if (sauceString.equals("red")) {
            image = R.drawable.pizza_supreme;
        } else if (checkbox_string.equals("canadian bacon")) {
            image = R.drawable.pizza_meat;
        } else image = R.drawable.pizza_cheese;
        p.setImageResource(image);

    }

    public void findPlace(View view){
        TextView pizzaPlace = (TextView) findViewById(R.id.pizzaPlaceText);
        RadioGroup crust = (RadioGroup) findViewById(R.id.crust_type);
        String pizzaString = " ";

        int crust_id = crust.getCheckedRadioButtonId();
        switch(crust_id){
            case -1:
                pizzaString = "";
                break;
            case R.id.radioButton1:
                pizzaString = "Backcountry Pizza";
                break;
            case R.id.radioButton2:
                pizzaString = "Pizzaria Locale";
                break;
            case R.id.radioButton3:
                pizzaString = "Pizza Calore";
                break;
            default:
                pizzaString = "nowhere";
        }
        pizzaPlace.setText("You should check out " + pizzaString);
    }
}
