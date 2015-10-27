
//
//  ViewController.swift
//  iTourCU
//
//  Created by Andrew Linenfelser on 9/23/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var previousPoint:CLLocation?
    private var totalMovementDistance:CLLocationDistance = 0
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var horizontalAccuracyLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var vericalAccuracyLabel: UILabel! //VERICAL NOT VERTICAL
    @IBOutlet weak var distanceTraveledLabel: UILabel!
    
    
    @IBOutlet var mapView:MKMapView!
    
    //for setting locations
    //@IBOutlet var map: MKMapView!
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let newLocation = (locations as! [CLLocation])[locations.count - 1]
        
        let latitudeString = String(format: "%g\u{00B0}", newLocation.coordinate.latitude)
        latitudeLabel.text = latitudeString
        let longitudeString = String(format: "%g\u{00B0}", newLocation.coordinate.longitude)
        longitudeLabel.text = longitudeString
        /*
        let horizontalAccuracyString = String(format:"%gm", newLocation.altitude)
        horizontalAccuracyLabel.text = horizontalAccuracyString
        let altitudeString = String(format: "%gm", newLocation.verticalAccuracy)
        altitudeLabel.text = altitudeString
        let verticalAccuracyString = String(format: "%gm", newLocation.verticalAccuracy)
        vericalAccuracyLabel.text = verticalAccuracyString
        */
        
        
        
        //accuracy values are in meters
        if newLocation.horizontalAccuracy < 0 {
            // invalid accuracy
            return
        }
        if newLocation.horizontalAccuracy > 100 || newLocation.verticalAccuracy > 50{
            //accuracy radius is too large, dont want to use
            return
        }
        if previousPoint == nil{
            totalMovementDistance = 0
            let start = Place(title: "Start Point", subtitle: "This is where we started", coordinate: newLocation.coordinate)
            mapView.addAnnotation(start)
            
            let region  = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100) //displays how wide and tall of a portion the map should be
            mapView.setRegion(region, animated: true)
            
        } else {
            //println("Movement Distance: " + "\(newLocation.distanceFromLocation(previousPoint))")
            totalMovementDistance += newLocation.distanceFromLocation(previousPoint)
        }
        
        previousPoint = newLocation
        
        
        let distanceString = String(format: "%gm", totalMovementDistance)
        distanceTraveledLabel.text = distanceString
        
    }
    
    
    //GETTING THE AUTHORIZATION TO USE CORE LOCATION
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("Authorization status changed to \(status.rawValue)")
        switch status{
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            //only stary after user has give permission
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation() //incase the user revokes authorization
            mapView.showsUserLocation = false
        }
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        let errorType = error.code == CLError.Denied.rawValue ? "Access Denied": "Error \(error.code)"
        let alertController = UIAlertController(title: "Location manager error", message: errorType, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: { action in })
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        //might not need
        //self.locationManager.startUpdatingLocation()
        
        
        //SET LOCATIONS
        var ENGR = CLLocationCoordinate2D(latitude: 40.006935, longitude: -105.262595)
        var annotationENGR = MKPointAnnotation()
        annotationENGR.coordinate = ENGR
        annotationENGR.title = "Engineering Center"
        annotationENGR.subtitle = "Where I live"
        mapView.addAnnotation(annotationENGR)
        
        var MATH = CLLocationCoordinate2D(latitude: 40.007757, longitude: -105.264646)
        var annotationMATH = MKPointAnnotation()
        annotationMATH.coordinate = MATH
        annotationMATH.title = "Math Building (MATH)"
        annotationMATH.subtitle = "This is where math is made"
        mapView.addAnnotation(annotationMATH)
        
        var C4C = CLLocationCoordinate2D(latitude: 40.004300,  longitude: -105.264964)
        var annotationC4C = MKPointAnnotation()
        annotationC4C.coordinate = C4C
        annotationC4C.title = "Center for the Community (C4C)"
        annotationC4C.subtitle = "This is where food is made"
        mapView.addAnnotation(annotationC4C)
        
        var FAR = CLLocationCoordinate2D(latitude: 40.006112, longitude: -105.267209)
        var annotationFAR = MKPointAnnotation()
        annotationFAR.coordinate = FAR
        annotationFAR.title = " Farrand Field (FAR)"
        annotationFAR.subtitle = "Just look at those faltirons!"
        mapView.addAnnotation(annotationFAR)
        
        var FOLS = CLLocationCoordinate2D(latitude: 40.009259,  longitude: -105.266905)
        var annotationFOLS = MKPointAnnotation()
        annotationFOLS.coordinate = FOLS
        annotationFOLS.title = "FOLS"
        annotationFOLS.subtitle = "This is where football and stuff is played, usually inhabited by drunk students"
        mapView.addAnnotation(annotationFOLS)
        
        var FISK = CLLocationCoordinate2D(latitude: 40.003713, longitude: -105.263500)
        var annotationFISK = MKPointAnnotation()
        annotationFISK.coordinate = FISK
        annotationFISK.title = "Fiske Plane-arium (FISK)"
        annotationFISK.subtitle = "This coolest fucking place on campus"
        mapView.addAnnotation(annotationFISK)
        
        var DUAN = CLLocationCoordinate2D(latitude: 40.008008, longitude: -105.267516)
        var annotationDUAN = MKPointAnnotation()
        annotationDUAN.coordinate = DUAN
        annotationDUAN.title = "Duane Physics and Astrophysics (DUAN)"
        annotationDUAN.subtitle = "This is where math is made"
        mapView.addAnnotation(annotationDUAN)

        
        /*
        var XXX = CLLocationCoordinate2D(latitude: 40.007757, longitude: -105.264646)
        var annotationXXX = MKPointAnnotation()
        annotationXXX.coordinate = XXX
        annotationXXX.title = "(XXX)"
        annotationXXX.subtitle = "This is where math is made"
        mapView.addAnnotation(annotationXXX)
        */
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

