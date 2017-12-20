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
        if regionToMonitor == nil {
            
            var location = locations.last as! CLLocation
            
            regionToMonitor = CLCircularRegion(center: location.coordinate,
                radius: 20.0, identifier: "StartingPoint")

            locationManager.startMonitoringForRegion(regionToMonitor)
            
            println("Now monitoring region \(regionToMonitor)")
            
        }
    }
    
    func locationManager(manager: CLLocationManager!,
        monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        println("Failed to start monitoring region!")

    }
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
        println("Entering region!")
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
        println("Exiting region!")
    }


}
// END regions


