//
//  ViewController.swift
//  Speed
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var speedLabel : UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
// BEGIN speed
func locationManager(manager: CLLocationManager!,
    didUpdateLocations locations: [AnyObject]!) {
        
    let lastLocation = locations.last as! CLLocation
        
    if lastLocation.speed > 0 {
        self.speedLabel.text = String(format:"Currently moving at %.0fms",
            lastLocation.speed)
    }
        
}
// END speed



}

