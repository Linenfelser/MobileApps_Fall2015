//
//  Place.swift
//  iTourCU
//
//  Created by Andrew Linenfelser on 9/25/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit
import MapKit

//This class is acting solely as a holder for these properties

class Place: NSObject, MKAnnotation {
    let title:String
    let subtitle:String
    var coordinate:CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
   
}
