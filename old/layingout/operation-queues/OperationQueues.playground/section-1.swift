// Playground - noun: a place where people can play

import UIKit



func UploadHighScores() {
    NSLog("Uploading high scores!")
}

func SaveGame() {
    NSLog("Saving game!")
}

func DownloadMaps() {
    NSLog("Downloading maps!")
}

func ProcessPlayerInput() {
    NSLog("Processing player input!")
}

// BEGIN operationqueue_operations
// Create a work queue to put tasks on
let concurrentQueue = NSOperationQueue()

// This queue can run 10 operations at the same time, at most
concurrentQueue.maxConcurrentOperationCount = 10

// Add some tasks
concurrentQueue.addOperationWithBlock {
    UploadHighScores()
}

concurrentQueue.addOperationWithBlock {
    SaveGame()
}

concurrentQueue.addOperationWithBlock {
    DownloadMaps()
}
// END operationqueue_operations

// BEGIN operationqueue_mainqueue

let mainQueue = NSOperationQueue.mainQueue()

mainQueue.addOperationWithBlock { () -> Void in
    ProcessPlayerInput()
}

// END operationqueue_mainqueue

// BEGIN operationqueue_queue_interaction
let backgroundQueue = NSOperationQueue()

backgroundQueue.addOperationWithBlock { () -> Void in
    
    // Do work in the background
    
    NSOperationQueue.mainQueue().addOperationWithBlock {
        
        // Once that's done, do work on the main queue
        
    }
}

// END operationqueue_queue_interaction

func PlaceBomb() {
    NSLog("Bomb placed!")
}

func ExplodeBomb() {
    NSLog("Boom!")
}

// BEGIN run_after_delay
// Place a bomb, but make it explode in 10 seconds
PlaceBomb()

let delayTime : Float = 10.0

let dispatchTime = dispatch_time(DISPATCH_TIME_NOW,
    Int64(delayTime * Float(NSEC_PER_SEC)))

let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)

dispatch_after(dispatchTime, queue) { () -> Void in
    // Time's up. Kaboom.
    ExplodeBomb()
}
// END run_after_delay

// BEGIN operation_dependencies
let firstOperation = NSBlockOperation { () -> Void in
    NSLog("First operation")
}

let secondOperation = NSBlockOperation { () -> Void in
    NSLog("Second operation")
}

let thirdOperation = NSBlockOperation { () -> Void in
    NSLog("Third operation")
}

// secondOperation will not run until firstOperation and 
// thirdOperation have finished
secondOperation.addDependency(firstOperation)
secondOperation.addDependency(thirdOperation)

NSOperationQueue.mainQueue().addOperations([firstOperation,
    secondOperation, thirdOperation], waitUntilFinished: true)

// END operation_dependencies


// BEGIN loading_assets

let imagesToLoad = ["Image 1.jpg", "Image 2.jpg", "Image 3.jpg"]

let imageLoadingQueue = NSOperationQueue()

// We want the main queue to run at close to regular speed, so mark this
// background queue as running in the background

// (Note: this is actually the default value, but it's good to know about
// the qualityOfService property.)
imageLoadingQueue.qualityOfService = NSQualityOfService.Background

// Allow loading multiple images at once
imageLoadingQueue.maxConcurrentOperationCount = 10

// Create an operation that will run when all images are loaded - you may want
// to tweak this
let loadingComplete = NSBlockOperation { () -> Void in
    NSLog("Loading complete!")
}

// Create an array for storing our loading operations
var loadingOperations : [NSOperation] = []

// Add a load operation for each image

for imageName in imagesToLoad {
    let loadOperation = NSBlockOperation { () -> Void in
        
        NSLog("Loading \(imageName)")
        
    }
    
    loadingOperations.append(loadOperation)
    
    // Don't run the loading complete operation until
    // this load (and all other loads) are done
    loadingComplete.addDependency(loadOperation)
}

imageLoadingQueue.addOperations(loadingOperations, waitUntilFinished: false)
imageLoadingQueue.addOperation(loadingComplete)

// END loading_assets

