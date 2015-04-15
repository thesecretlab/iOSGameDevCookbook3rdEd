// Playground - noun: a place where people can play

import UIKit

// BEGIN closure_example
class GameObject {
    // define a type of closure that takes a single GameObject
    // as a parameter and returns nothing
    var onCollision : (GameObject -> Void)?
}

// Create two objects for this example
let car = GameObject()
let brickWall = GameObject()

// Provide code to run when the car hits any another object
car.onCollision = { (objectWeHit) in
    NSLog("Car collided with \(objectWeHit)")
}

// later, when a character collides:
car.onCollision?(brickWall) // note the ? - this means that
                            // the code will only run if onCollision
                            // is not nil

// END closure_example

// BEGIN closure_explanation
var multiplyNumber : Int -> Int // <1>

multiplyNumber = { (number) -> Int in // <2>
    
    return number * 2
    
}

multiplyNumber(2) // <3>
// END closure_explanation

// BEGIN closure_typealias
typealias ErrorHandler = NSError -> Void

var myErrorHandler : ErrorHandler

myErrorHandler = { (theError) in
    // do work with theError
    NSLog("i SPILL my DRINK! \(theError)")
}
// END closure_typealias

// BEGIN closure_as_parameter
func moveToPosition(position : CGPoint, completion: (Void->Void)?) {
    
    // Do the actual work of moving to the location, which
    // might take place over several frames
    
    // Call the completion handler, if it exists
    completion?()
}

let destination = CGPoint(x: 5, y: 3)

// Call the function and provide the closure as a parameter
moveToPosition(destination) {
    NSLog("Arrived!")
}
// END closure_as_parameter