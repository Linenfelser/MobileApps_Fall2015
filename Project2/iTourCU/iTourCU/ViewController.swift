
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
    
    //@IBOutlet weak var horizontalAccuracyLabel: UILabel!
    //@IBOutlet weak var altitudeLabel: UILabel!
    //@IBOutlet weak var vericalAccuracyLabel: UILabel! //VERICAL NOT VERTICAL
    @IBOutlet weak var distanceTraveledLabel: UILabel!
    
    //information to display
    @IBOutlet weak var buildingNamelabel: UILabel!
    @IBOutlet weak var buildingInfoView: UITextView!
    
    @IBOutlet var mapView:MKMapView!
    
    //for setting locations
    //@IBOutlet var map: MKMapView!
    
    func updateInformation(buildingName: NSString, buildingInfo: NSString){
        buildingNamelabel.text = buildingName as String
        buildingInfoView.text = buildingInfo as String
    
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
        annotationENGR.title = "The Engineering Center"
        annotationENGR.subtitle = " The center comprises 660,000 square feet of classrooms"
        /*, computing facilities, faculty offices, and research laboratories in an architecturally distinctive and thoroughly modern building. The center is home to the nation's largest geotechnical centrifuge, ion-implantation and microwave-propagation facilities, several clean rooms, low-turbulence wind tunnels, spectrometers, electron and other microscopes, and a structural analysis facility.Each department is extensively supported by networked computers, and computers are available throughout the center for student use. A wireless network provides wireless Internet access throughout the complex. "*/
        mapView.addAnnotation(annotationENGR)
        updateInformation(annotationENGR.title, buildingInfo: annotationENGR.subtitle)
        
        
        
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
        annotationFOLS.title = "Folsom Field"
        annotationFOLS.subtitle = "CU Boulder's football stadium"
        mapView.addAnnotation(annotationFOLS)
        
        var FISK = CLLocationCoordinate2D(latitude: 40.003713, longitude: -105.263500)
        var annotationFISK = MKPointAnnotation()
        annotationFISK.coordinate = FISK
        annotationFISK.title = "Fiske Plane-arium (FISK)"
        annotationFISK.subtitle = "This coolest place on campus, has state of the art telescopes and a one of a kind planetarium"
        mapView.addAnnotation(annotationFISK)
        
        var DUAN = CLLocationCoordinate2D(latitude: 40.008008, longitude: -105.267516)
        var annotationDUAN = MKPointAnnotation()
        annotationDUAN.coordinate = DUAN
        annotationDUAN.title = "Duane Physics and Astrophysics (DUAN)"
        annotationDUAN.subtitle = "This is where math is made"
        mapView.addAnnotation(annotationDUAN)

        var NOR = CLLocationCoordinate2D(latitude: 40.008847, longitude: -105.270758)
        var annotationNOR = MKPointAnnotation()
        annotationNOR.coordinate = NOR
        annotationNOR.title = "Norlin Library"
        annotationNOR.subtitle = "The main Library on campus"
        mapView.addAnnotation(annotationNOR)
        
        var OLD = CLLocationCoordinate2D(latitude: 40.009234,  longitude: -105.273247)
        var annotationOLD = MKPointAnnotation()
        annotationOLD.coordinate = OLD
        annotationOLD.title = "Old Main (CU Heritage Center"
        annotationOLD.subtitle = "This was the first building on campus"
        mapView.addAnnotation(annotationOLD)
        
        
        var UMC = CLLocationCoordinate2D(latitude: 40.006775, longitude: -105.271299)
        var annotationUMC = MKPointAnnotation()
        annotationUMC.coordinate = UMC
        annotationUMC.title = "University Memorial Center (UMC)"
        annotationUMC.subtitle = "Everything from the CU Bookstore and the Alfred Packard grill to bowling and study rooms can be found here "
        mapView.addAnnotation(annotationUMC)

        
        /*
        var UMC = CLLocationCoordinate2D(latitude: 40.007757, longitude: -105.264646)
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

