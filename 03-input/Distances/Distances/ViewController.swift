//
//  ViewController.swift
//  Distances
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

// BEGIN regions
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var regionToMonitor : CLCircularRegion?


    override func viewDidLoad() {
        locationManager.delegate = self;
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager!,
        didUpdateLocations locations: [AnyObject]!) {
        
        // Only start monitoring a region when we first get
        // a location
        guard regionToMonitor == nil else {
            return
        }
    
        let location = locations.last as! CLLocation
        
        let region = CLCircularRegion(center: location.coordinate,
            radius: 20.0, identifier: "StartingPoint")

        locationManager.startMonitoring(for: region)
        
        
        print("Now monitoring region \(region)")
        
        regionToMonitor = region
        
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         monitoringDidFailFor region: CLRegion?,
                         withError error: Error) {
        print("Failed to start monitoring region!")

    }
    
    func locationManager(_ manager: CLLocationManager,
                         didEnterRegion region: CLRegion) {
        print("Entering region!")
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        print("Exiting region!")
    }


}
// END regions


