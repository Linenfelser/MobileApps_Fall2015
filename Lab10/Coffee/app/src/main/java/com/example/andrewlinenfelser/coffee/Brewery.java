package com.example.andrewlinenfelser.coffee;

/**
 * Created by andrewlinenfelser on 11/17/15.
 */
public class Brewery {
    private String breweryName;
    private String breweryURL;

    private void setBeerInfo(String beerCrowd){
        switch (beerCrowd){
            case "Local":
                breweryName = "Boulder Beer";
                breweryURL = "http://boulderbeer.com/";
                break;
            case "Hidden":
                breweryName = "Twisted Pine";
                breweryURL = "https://twistedpinebrewing.com/";
                break;
            case "Awesome Beer and Food":
                breweryName = "Oskar Blues";
                breweryURL = "http://www.oskarblues.com/";
                break;
            case "Big Name":
                breweryName = "Avery Brewing";
                breweryURL = "http://averybrewing.com/";
                break;
            case "Good Beer and Food":
                breweryName = "Fate Brewing Company";
                breweryURL = "http://fatebrewingcompany.com/";
                break;
            default:
                breweryName = "None";
                breweryURL = "https://www.google.com/search?q=beeradvocate&rlz=1C5CHFA_enUS551US551&oq=beer&aqs=chrome.0.0j69i57j0l4.495j0j4&sourceid=chrome&es_sm=91&ie=UTF-8#q=beer";
        }
    }
    public void setBreweryName(String beerCrowd){
        setBeerInfo(beerCrowd);
    }
    public void setBreweryURL(String beerCrowd){
        setBeerInfo(beerCrowd);
    }
    public String getBreweryName(){

        return breweryName;
    }
    public String getBreweryURL(){

        return breweryURL;
    }
}
