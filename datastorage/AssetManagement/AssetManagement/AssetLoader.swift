//
//  AssetLoader.swift
//  AssetManagement
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN asset_loader
class AssetLoader: NSObject {
    
    class func loadAssetsAtURLs(urls: [NSURL],
        withEnumerationBlock loadingComplete: (NSURL, NSData?, NSError?) -> Void) {
        
        // Create a queue
        let loadingQueue = NSOperationQueue()
        
        // For convenience, define a loading result as a tuple
        // containing the URL of the resource that was loaded,
        // and either the loaded data or an error
        typealias LoadingResult = (url: NSURL, data: NSData?, error: NSError?)

        // Create an array of results
        var loadingResults : [LoadingResult] = []
        
        // The loading complete operation runs the loadingComplete block
        // when all loads are finished
        let loadingCompleteOperation = NSBlockOperation { () -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                // Call the loadingComplete block for each result
                for result in loadingResults {
                    loadingComplete(result.url, result.data, result.error)
                }
            }
        }
        
        // Start loading the data at each URL
        for url in urls {
            
            // Create an operation that will load the data in the background
            let loadOperation = NSBlockOperation{ () -> Void in
                // Attempt to load the data
                var error : NSError? = nil
                var result : LoadingResult? = nil
                
                // If we got it, result contains the data
                if let data = NSData(contentsOfURL: url,
                    options: NSDataReadingOptions.allZeros, error: &error) {
                    result = (url: url, data: data, error:nil)
                } else {
                    // Else the result contains an error
                    result = (url: url, data: nil, error:error)
                }
                
                // On the main queue (to prevent conflicts), 
                // add this operation's result to the list
                NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                    loadingResults.append(result!)
                }
            }
            
            // Add a dependency to the loading complete operation,
            // so that it won't run until this load (and all others)
            // have completed
            loadingCompleteOperation.addDependency(loadOperation)
            
            // Add this load operation to the queue
            loadingQueue.addOperation(loadOperation)
        }
        
        // Add the loading complete operation to the queue.
        // Because it has dependencies on the load operations,
        // it won't run until all files have been loaded
        loadingQueue.addOperation(loadingCompleteOperation)
    }
   
}
// END asset_loader

