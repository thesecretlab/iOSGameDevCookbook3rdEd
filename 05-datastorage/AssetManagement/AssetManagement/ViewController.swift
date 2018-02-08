//
//  ViewController.swift
//  AssetManagement
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // BEGIN assetmanagement_usage
        // Get the list of all .png files in the bundles, or the empty array
        let urls = Bundle.main
            .urls(forResourcesWithExtension: "png",
                  subdirectory: nil) ?? []
        
        
        // Load all these images
        AssetLoader.loadAssets(at: urls) {
            (url, data, error) -> Void in
            
            // This block is called once for each URL
            
            if let data = data {
                print("Loaded resource \(url.lastPathComponent) (\(data.count) bytes)")
            } else if let error = error {
                print("Failed to load resource \(url.lastPathComponent): \(error)")
            } else {
                fatalError("Didn't get data or an error; this should not happen!")
            }
        }
        // END assetmanagement_usage
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


