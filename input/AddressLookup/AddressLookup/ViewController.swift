//
//  ViewController.swift
//  AddressLookup
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    @IBOutlet weak var labelTextView : UITextView!
    
    override func viewDidLoad() {
        locationManager.delegate = self
        
        locationManager.distanceFilter = 100
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
// BEGIN lookup
func locationManager(manager: CLLocationManager!,
    didUpdateLocations locations: [AnyObject]!) {
    let location = locations.last as! CLLocation
        
    geocoder.reverseGeocodeLocation(location, completionHandler: {
        (placemarks, error) -> Void in
        let addressString =
            (placemarks.first as! CLPlacemark).name
            
        self.labelTextView.text = addressString
            
    })
}
// END lookup

}

