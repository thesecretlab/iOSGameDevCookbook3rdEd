//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func UploadHighScores() {
    print("Uploading high scores!")
}

func SaveGame() {
    print("Saving game!")
}

func DownloadMaps() {
    print("Downloading maps!")
}

func ProcessPlayerInput() {
    print("Processing player input!")
}

// BEGIN operationqueue_operations
// Create a work queue to put tasks on
let concurrentQueue = OperationQueue()

// This queue can run 10 operations at the same time, at most
concurrentQueue.maxConcurrentOperationCount = 10

// Add some tasks
concurrentQueue.addOperation {
    UploadHighScores()
}

concurrentQueue.addOperation {
    SaveGame()
}

concurrentQueue.addOperation {
    DownloadMaps()
}
// END operationqueue_operations

// BEGIN operationqueue_mainqueue

let mainQueue = OperationQueue.main

mainQueue.addOperation { () -> Void in
    ProcessPlayerInput()
}

// END operationqueue_mainqueue

// BEGIN operationqueue_queue_interaction
let backgroundQueue = OperationQueue()

backgroundQueue.addOperation { () -> Void in
    
    // Do work in the background
    
    OperationQueue.main.addOperation {
        
        // Once that's done, do work on the main queue
        
    }
}

// END operationqueue_queue_interaction

func PlaceBomb() {
    print("Bomb placed!")
}

func ExplodeBomb() {
    print("Boom!")
}

// BEGIN run_after_delay
// Place a bomb, but make it explode in 10 seconds
PlaceBomb()

let deadline = DispatchTime.now() + 10

DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
    // Time's up. Kaboom.
    ExplodeBomb()
})

// END run_after_delay

// BEGIN operation_dependencies
let firstOperation = BlockOperation { () -> Void in
    print("First operation")
}

let secondOperation = BlockOperation { () -> Void in
    print("Second operation")
}

let thirdOperation = BlockOperation { () -> Void in
    print("Third operation")
}

// secondOperation will not run until firstOperation and
// thirdOperation have finished
secondOperation.addDependency(firstOperation)
secondOperation.addDependency(thirdOperation)

let operations = [firstOperation, secondOperation, thirdOperation]

backgroundQueue.addOperations(operations, waitUntilFinished: true)

// END operation_dependencies


// BEGIN loading_assets
let imagesToLoad = ["Image 1.jpg", "Image 2.jpg", "Image 3.jpg"]

let imageLoadingQueue = OperationQueue()

// We want the main queue to run at close to regular speed, so mark this
// background queue as running in the background

// (Note: this is actually the default value, but it's good to know about
// the qualityOfService property.)
imageLoadingQueue.qualityOfService = QualityOfService.background

// Allow loading multiple images at once
imageLoadingQueue.maxConcurrentOperationCount = 10

// Create an operation that will run when all images are loaded - you may want
// to tweak this
let loadingComplete = BlockOperation { () -> Void in
    print("Loading complete!")
}

// Create an array for storing our loading operations
var loadingOperations : [Operation] = []

// Add a load operation for each image

for imageName in imagesToLoad {
    let loadOperation = BlockOperation { () -> Void in
        
        print("Loading \(imageName)")
        
    }
    
    loadingOperations.append(loadOperation)
    
    // Don't run the loading complete operation until
    // this load (and all other loads) are done
    loadingComplete.addDependency(loadOperation)
}

imageLoadingQueue.addOperations(loadingOperations, waitUntilFinished: false)
imageLoadingQueue.addOperation(loadingComplete)

//: [Next](@next)
