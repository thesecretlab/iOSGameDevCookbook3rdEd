//
//  ViewController.swift
//  UserLocation
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

// BEGIN location
import UIKit
import CoreLocation

// BEGIN class_decl
class ViewController: UIViewController, CLLocationManagerDelegate {
// END class_decl
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel : UILabel!
    @IBOutlet weak var longitudeLabel : UILabel!
    @IBOutlet weak var locationErrorLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BEGIN begin_usage
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        // END begin_usage
        
        self.locationErrorLabel.hidden = true
    }
    
    func locationManager(manager: CLLocationManager!,
        didUpdateLocations locations: [AnyObject]!) {
        self.locationErrorLabel.hidden = true
        
        // BEGIN last
        var location = locations.last as! CLLocation
        // END last
        
        // BEGIN lat_lon
        var latitude = location.coordinate.latitude
        var longitude = location.coordinate.longitude
        // END lat_lon
        
        self.latitudeLabel.text = String(format: "Latitude: %.4f", latitude)
        self.longitudeLabel.text = String(format: "Longitude: %.4f", longitude)
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
        self.locationErrorLabel.hidden = false
    }

}
// END location
