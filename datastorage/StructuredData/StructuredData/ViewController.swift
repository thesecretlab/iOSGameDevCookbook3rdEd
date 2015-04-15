//
//  ViewController.swift
//  StructuredData
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func locationToSaveTo() -> NSURL {
        return (NSFileManager.defaultManager()
            .URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,
                inDomains: NSSearchPathDomainMask.UserDomainMask).last
                as! NSURL)
            .URLByAppendingPathComponent("Data.json")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
// BEGIN saving_json
let informationToSave = [
    "playerName": "Grabthar",
    "weaponType": "Hammer",
    "hitPoints": 1000,
    "currentQuests": ["save the galaxy", "get home"]
]
        
let url : NSURL = locationToSaveTo()
        
var error : NSError? = nil

let dataToSave = NSJSONSerialization.dataWithJSONObject(informationToSave,
    options: NSJSONWritingOptions.allZeros, error: &error)
        
if error != nil {
    println("Failed to convert to JSON! \(error)")
}
        
dataToSave?.writeToURL(url, atomically: true)
// END saving_json
        
// BEGIN loading_json
// Load the data
if let loadedData = NSData(contentsOfURL: url) {
            
    // Attempt to convert it to a dictionary that
    // maps strings to objects:
    var error : NSError? = nil
    let loadedInformation =
        NSJSONSerialization.JSONObjectWithData(
            loadedData,
            options: NSJSONReadingOptions.allZeros,
            error: &error) as? [String:AnyObject]
            
    // If we couldn't load it, or we couldn't load it
    // as the right type, log an error
    if loadedInformation == nil {
        println("Error loading data! \(error)")
    }
}
// END loading_json
        
// BEGIN validating_objects
// Checking to see if an object is convertible to JSON
let dictionaryToCheck = ["canIDoThis": true]
        
let canBeConverted =
        NSJSONSerialization.isValidJSONObject(dictionaryToCheck) // == true
// END validating_objects
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

