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
    
    // For convenience, define a loading result as a tuple
    // containing the URL of the resource that was loaded,
    // and either the loaded data or an error
    typealias LoadingResult = (url: URL, data: Data?, error: Error?)
    
    // Also define a
    typealias LoadingResultHandler = (URL, Data?, Error?) -> Void
    
    class func loadAssets(at urls: [URL],
        withEnumerationBlock loadingComplete: @escaping LoadingResultHandler) {
        
        // Create a queue
        let loadingQueue = OperationQueue()
        
        // Create an array of results
        var loadingResults : [LoadingResult] = []
        
        // The loading complete operation runs the loadingComplete block
        // when all loads are finished
        let loadingCompleteOperation = BlockOperation { () -> Void in
            
            OperationQueue.main.addOperation { () -> Void in
                // Call the loadingComplete block for each result
                for result in loadingResults {
                    loadingComplete(result.url, result.data, result.error)
                }
            }
        }
        
        // Start loading the data at each URL
        for url in urls {
            
            // Create an operation that will load the data in the background
            let loadOperation = BlockOperation { () -> Void in
                // Attempt to load the data
                let result : LoadingResult
                
                do {
                    let data = try Data(contentsOf: url, options: [])
                    
                    // If we got it, result contains the data
                    
                    result = (url: url, data: data, error:nil)
                } catch let error {
                    result = (url: url, data: nil, error:error)
                }
                
                // On the main queue (to prevent conflicts), 
                // add this operation's result to the list
                OperationQueue.main.addOperation { () -> Void in
                    loadingResults.append(result)
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

