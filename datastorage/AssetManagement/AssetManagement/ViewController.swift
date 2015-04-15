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
        
// BEGIN usage
// Get the list of all .png files in the bundles
let urls = NSBundle.mainBundle()
    .URLsForResourcesWithExtension("png", subdirectory: nil)
    as! [NSURL]
        
// Load all these images
AssetLoader.loadAssetsAtURLs(urls,
    withEnumerationBlock: { (url, data, error) -> Void in
            
    // This block is called once for each URL
    if error != nil {
        println("Failed to load resource \(url.lastPathComponent): \(error!)")
    } else {
        println("Loaded resource \(url.lastPathComponent) (\(data?.length) bytes)")
    }
            
})
// END usage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

 