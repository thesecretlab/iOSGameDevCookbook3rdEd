// Playground - noun: a place where people can play

import UIKit

// BEGIN array_filtering
let array = ["One", "Two", "Three", "Four", "Five"]

NSLog("Original array: \(array)")

let filteredArray = filter(array) { (element) -> Bool in
    if element.rangeOfString("e") != nil {
        return true
    } else {
        return false
    }
}

NSLog("Filtered array: \(filteredArray)")
// END array_filtering

