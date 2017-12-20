//
//  ViewController.swift
//  SavingHighScores
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerName = "Jenny McSampleplayer"
        
// BEGIN store_data
// Store each high-score you want to save in a
// dictionary
let scoreDictionary = [
    "score": 1000,
    "date":NSDate(),
    "playerName": playerName
]
        
// Store the list of scores you want to save in an
// array. (In real life, you would probably have more
// than one highscore to record)
let highScores = [scoreDictionary]
// END store_data

// BEGIN locate_url
let fileManager = NSFileManager.defaultManager()
let documentsURL = fileManager.URLsForDirectory(
    NSSearchPathDirectory.DocumentDirectory,
    inDomains:NSSearchPathDomainMask.UserDomainMask).last as! NSURL
        
let highScoreURL = documentsURL
    .URLByAppendingPathComponent("HighScores.plist")
// END locate_url

// BEGIN write_data
// We need to cast the array to NSArray, in order to
// get access to the writeToURL method
(highScores as NSArray).writeToURL(highScoreURL, atomically:true)
// END write_data
        
// BEGIN read_data
// Load the array as an array of dictionaries mapping Strings to
// other objects
// If it can't be loaded, or doesn't contain this type, result is nil
if let loadedHighScores
    = NSArray(contentsOfURL: highScoreURL) as? [[String:AnyObject]] {
    println("Loaded high scores:\(loadedHighScores)")
} else {
    println("Error loading high scores!")
}
// END read_data

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

