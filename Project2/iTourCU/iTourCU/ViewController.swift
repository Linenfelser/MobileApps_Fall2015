
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
import Foundation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    //private var previousPoint:CLLocation?
    private var totalMovementDistance:CLLocationDistance = 0
    //@IBOutlet weak var latitudeLabel: UILabel!
    //@IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var distanceTraveledLabel: UILabel!
    @IBOutlet weak var buildingNamelabel: UILabel!
    @IBOutlet weak var buildingInfoView: UITextView!
    //var editable: Bool
    @IBOutlet weak var buildingImage: UIImageView!
    
    //textView.editable = False
    
    //@IBOutlet weak var buildingInfoLabel: UILabel!
    @IBOutlet var mapView:MKMapView!
    
    //declare global var for just user lat and long and update in function manager
    var userLat:Double?
    var userLong:Double?
    
    
    
    var buildingDict = [["latitude": 40.006935, "longitude": -105.262595, "name": "Engineering Building", "info": " The center comprises 660,000 square feet of classrooms, computing facilities, faculty offices, and research laboratories in an architecturally distinctive and thoroughly modern building. The center is home to the nation's largest geotechnical centrifuge, ion-implantation and microwave-propagation facilities, several clean rooms, low-turbulence wind tunnels, spectrometers, electron and other microscopes, and a structural analysis facility.Each department is extensively supported by networked computers, and computers are available throughout the center for student use. A wireless network provides wireless Internet access throughout the complex.", "image": "engr"]]
    
    
    
//    func update(){
//        println("updating")
//    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        buildingInfoView.editable = false
        
        let c = buildingDict[0]
        let a = c["latitude"]
    
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(manager.location.coordinate, span)
        mapView.setRegion(region, animated: true)
        //NEED TO GET USER LOCATION TO UPDATE INFO
        var userLocation = "Latitude: \(manager.location.coordinate.latitude), Longitude: \(manager.location.coordinate.longitude)"
        
        userLat = manager.location.coordinate.latitude as? Double
        userLong = manager.location.coordinate.longitude as? Double
        
        
        for i in buildingDict{
            let lat = i["latitude"] as! Double
            let long = i["longitude"] as! Double
            let img = i["image"] as! String
            println("image is: \(img)")
//            println("building lat : \(lat)")
//            println("building long : \(long)")
            if userLat >= (lat - 0.00025) && userLat <= (lat + 0.00025) && userLong >= (long - 0.00025) && userLong <= (long + 0.00025) {
                println("WORKING")
                buildingNamelabel.text = i["name"] as? String
                buildingInfoView.text = i["info"] as? String
                buildingImage.image = UIImage(named: img)
            }
            
            else if userLat <= (40.0000) || userLat >= (40.02) || userLong >= (-105.257) || userLong <= (-105.278){
                buildingNamelabel.text = "Not On Campus"
                buildingInfoView.text = "Please move closer to campus and try again..."
            }
//            else{
//                buildingNamelabel.text = "Not Available"
//                buildingInfoLabel.text = "Please move to CU campus and try again"
//            }
        }
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
        //buildingArray.append("ENGR")
        //buildingDict.append(["latitude": 40.006935, "longitude": -105.262595, "name": "Engineering Building", "info": " The center comprises 660,000 square feet of classrooms, computing facilities, faculty offices, and research laboratories in an architecturally distinctive and thoroughly modern building. The center is home to the nation's largest geotechnical centrifuge, ion-implantation and microwave-propagation facilities, several clean rooms, low-turbulence wind tunnels, spectrometers, electron and other microscopes, and a structural analysis facility.Each department is extensively supported by networked computers, and computers are available throughout the center for student use. A wireless network provides wireless Internet access throughout the complex."])
        var annotationENGR = MKPointAnnotation()
        annotationENGR.coordinate = ENGR
        annotationENGR.title = "The Engineering Center"
        mapView.addAnnotation(annotationENGR)
        println("___UPDATING___engr...")
        //updateInformation(engrDict)
        
        var HOME = CLLocationCoordinate2D(latitude: 40.020385, longitude: -105.264540)
        buildingDict.append (["latitude": 40.020385, "longitude": -105.264540, "name": "Home", "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", "image": "math"])
        var annotationHOME = MKPointAnnotation()
        annotationHOME.coordinate = HOME
        annotationHOME.title = "Casa"
        println("___UPDATING___math...")
        mapView.addAnnotation(annotationHOME)
        
        
        var MATH = CLLocationCoordinate2D(latitude: 40.007757, longitude: -105.264646)
        //buildingArray.append("MATH")
        buildingDict.append (["latitude": 40.007757, "longitude": -105.264646, "name": "Math Building", "info": "Home of the Department of Mathematics and an expanded Engineering Library", "image": "math"])
        var annotationMATH = MKPointAnnotation()
        annotationMATH.coordinate = MATH
        annotationMATH.title = "Math Building (MATH)"
        println("___UPDATING___math...")
        mapView.addAnnotation(annotationMATH)
        //updateInformation(mathDict)
        
        
        var C4C = CLLocationCoordinate2D(latitude: 40.004300,  longitude: -105.264964)
        //var c4cDict = ["latitude": 40.004300, "longitude": -105.26464, "name": "Center For the Community", "info": "This is where students go to get food"]
        buildingDict.append(["latitude": 40.004300, "longitude": -105.26464, "name": "Center For the Community", "info": "The dynamic student center features centralized key student services and programs on the upper floors including Career Services, International Education, and Counseling and Psychological Services, among others. The center is home to the largest dining center on campus with the capacity to serve 900 people and the flexibility to host special events and meetings with an underground parking garage to support access.", "image": "c4c"])
        var annotationC4C = MKPointAnnotation()
        annotationC4C.coordinate = C4C
        annotationC4C.title = "Center for the Community (C4C)"
        //annotationC4C.subtitle = "This is where food is made"
        println("___UPDATING___C4C...")
        mapView.addAnnotation(annotationC4C)
        //updateInformation(c4cDict)
        
        
        var FAR = CLLocationCoordinate2D(latitude: 40.006112, longitude: -105.267209)
        //buildingArray.append("FAR")
        buildingDict.append(["latitude": 40.006112, "longitude": -105.267209, "name": "Farrand Field", "info": "Beautiful field with an amazing view of the flatirons. Farrand Field is inbetween many dorms making it a popular spot for sutudents to hang out.", "image": "far"])
        var annotationFAR = MKPointAnnotation()
        annotationFAR.coordinate = FAR
        annotationFAR.title = " Farrand Field (FAR)"
        //annotationFAR.subtitle = "Just look at those faltirons!"
        mapView.addAnnotation(annotationFAR)
        
        var FOLS = CLLocationCoordinate2D(latitude: 40.009259,  longitude: -105.266905)
        //buildingArray.append("FOLS")
        buildingDict.append(["latitude": 40.009259, "longitude": -105.266905, "name": "Folsom Field", "info": "Folsom Field,home of Colorado Football Since 1924. \nCurrent Capacity: 50,183. \nElevation: 5,440 ft.", "image": "fols"])
        var annotationFOLS = MKPointAnnotation()
        annotationFOLS.coordinate = FOLS
        annotationFOLS.title = "Folsom Field"
        //annotationFOLS.subtitle = "CU Boulder's football stadium"
        mapView.addAnnotation(annotationFOLS)
        
        var FISK = CLLocationCoordinate2D(latitude: 40.003713, longitude: -105.263500)
        //buildingArray.append("FISK")
        buildingDict.append(["latitude": 40.003713, "longitude": -105.263500, "name": "Fiske Plane-arium", "info": "This coolest place on campus, has state of the art telescopes and a one of a kind planetarium. Our Lobby Exhibits are free and open to the public during our business hours. We are open on select Saturdays depending on the CU football schedule. We are available for private events such as birthday parties and corporate events. Please call 303-492-5002 for more information. During our public shows on Thursdays, Fridays, Saturdays and Sundays the building opens 30 minutes before show time.", "image": "fisk"])
        var annotationFISK = MKPointAnnotation()
        annotationFISK.coordinate = FISK
        annotationFISK.title = "Fiske Plane-arium (FISK)"
        //annotationFISK.subtitle = "This coolest place on campus, has state of the art telescopes and a one of a kind planetarium"
        mapView.addAnnotation(annotationFISK)
        
        var DUAN = CLLocationCoordinate2D(latitude: 40.008008, longitude: -105.267516)
        //buildingArray.append("DUAN")
        buildingDict.append(["latitude": 40.008008, "longitude": -105.267516, "name": "Duane Physics and Astrophysics", "info": "Duane Physics", "image": "duane"])
        var annotationDUAN = MKPointAnnotation()
        annotationDUAN.coordinate = DUAN
        annotationDUAN.title = "Duane Physics and Astrophysics (DUAN)"
        //annotationDUAN.subtitle = "This is where physics is made"
        mapView.addAnnotation(annotationDUAN)

        var NOR = CLLocationCoordinate2D(latitude: 40.008847, longitude: -105.270758)
        //buildingArray.append("NOR")
        buildingDict.append(["latitude": 40.008847, "longitude": -105.270758, "name": "Norlin Library", "info": "Norlin Commons was created so students, faculty, and staff would have access to technology, IT support, writing help, and research assistance in one space.", "image": "nor"])
        var annotationNOR = MKPointAnnotation()
        annotationNOR.coordinate = NOR
        annotationNOR.title = "Norlin Library"
        //annotationNOR.subtitle = "The main Library on campus"
        mapView.addAnnotation(annotationNOR)
        
        var OLD = CLLocationCoordinate2D(latitude: 40.009234,  longitude: -105.273247)
        //buildingArray.append("OLD")
        buildingDict.append(["latitude": 40.009234, "longitude": -105.273247, "name": "Old Main (1876)", "info": "When Old Main was built, there were no buildings or trees nearby—only grasses and cacti. At first, the university could barely fill Old Main even though it included living quarters for the president and his family. However, the building was soon bursting with a library, the cabinets that were the beginning of a museum, collections of highly prized laboratory instruments", "image": "old"])
        var annotationOLD = MKPointAnnotation()
        annotationOLD.coordinate = OLD
        annotationOLD.title = "Old Main (CU Heritage Center"
        //annotationOLD.subtitle = "This was the first building on campus"
        mapView.addAnnotation(annotationOLD)
        
        var UMC = CLLocationCoordinate2D(latitude: 40.006775, longitude: -105.271299)
        //buildingArray.append("UMC")
        buildingDict.append(["latitude": 40.006775, "longitude": -105.271299, "name": "University Memorial Center", "info": "Known as the campus “living room,” thousands of people visit the University Memorial Center (UMC) every day to grab a bite to eat, enjoy free entertainment, shop the retail stores, study with free wireless internet, or just hang out.", "image": "image2"])
        var annotationUMC = MKPointAnnotation()
        annotationUMC.coordinate = UMC
        annotationUMC.title = "University Memorial Center (UMC)"
        //annotationUMC.subtitle = "Everything from the CU Bookstore and the Alfred Packard grill to bowling and study rooms can be found here "
        mapView.addAnnotation(annotationUMC)
        
        var ATLS = CLLocationCoordinate2D(latitude: 40.007665, longitude: -105.269556)
        buildingDict.append(["latitude": 40.007665, "longitude": -105.269556, "name": "Atlas Institute", "info": "The ATLAS Institute is a center of interdisciplinary research, learning, and collaboration in engineering, creative technologies and design. Attracting researchers and students whose interests bridge the artistic and technical, the building houses the Interactive Robotics and Novel Technologies Lab, the BTU Lab hackerspace, the Laboratory for Playful Computation, the Black Box Experimental Studio and the National Center for Women and Information Technology.", "image": "atls"])
        var annotationATLS = MKPointAnnotation()
        annotationATLS.coordinate = ATLS
        annotationATLS.title = "ATLAS Institute"
        mapView.addAnnotation(annotationATLS)
        
        var MACK = CLLocationCoordinate2D(latitude: 40.010046, longitude: -105.272862)
        buildingDict.append(["latitude": 40.010046, "longitude": -105.272862, "name": "Macky Auditorium", "info": "Macky Auditorium Concert Hall is a multi-disciplinary venue, and a largely self-funded unit of the University of Colorado Boulder. One of the 12 buildings that form the Norlin Quadrangle Historic District, it serves the campus and the region by entertaining, educating and challenging audiences with high quality local, national and international performances and events.", "image": "mack"])
        var annotationMACK = MKPointAnnotation()
        annotationMACK.coordinate = MACK
        annotationMACK.title = "Macky Auditorium"
        mapView.addAnnotation(annotationMACK)
        
        /*
        var XXX = CLLocationCoordinate2D(latitude: 40.007757, longitude: -105.264646)
        buildingDict.append(["latitude": 40.007665, "longitude": -105.269556, "name": "Atlas Institute", "info": "The info goes here.", "image": "img"])
        var annotationXXX = MKPointAnnotation()
        annotationXXX.coordinate = XXX
        annotationXXX.title = "(XXX)"
        annotationXXX.subtitle = "This is where math is made"
        mapView.addAnnotation(annotationXXX)
        */
        
        //var timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("LocationManager1"), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

