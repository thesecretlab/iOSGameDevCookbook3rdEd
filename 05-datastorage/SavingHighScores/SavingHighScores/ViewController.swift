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
        let scoreDictionary : [String : Any] = [
            "score": 1000,
            "date":Date(),
            "playerName": playerName
        ]
        
        // Store the list of scores you want to save in an
        // array. (In real life, you would probably have more
        // than one highscore to record)
        let highScores = [scoreDictionary]
        // END store_data
        
        // BEGIN locate_url
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(
            for: FileManager.SearchPathDirectory.documentDirectory,
            in:FileManager.SearchPathDomainMask.userDomainMask).last!
        
        let highScoreURL = documentsURL
            .appendingPathComponent("HighScores.plist")
        // END locate_url
        
        // BEGIN write_data
        // We need to cast the array to NSArray, in order to
        // get access to the writeToURL method
        (highScores as NSArray).write(to: highScoreURL, atomically:true)
        // END write_data
        
        // BEGIN read_data
        // Load the array as an array of dictionaries mapping Strings to
        // other objects
        // If it can't be loaded, or doesn't contain this type, result is nil
        if let loadedHighScores = NSArray(contentsOf: highScoreURL) as? [[String:AnyObject]] {
            print("Loaded high scores:\(loadedHighScores)")
        } else {
            print("Error loading high scores!")
        }
        // END read_data
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

