//: [Previous](@previous)

import Foundation

// BEGIN array_filtering
let array = ["One", "Two", "Three", "Four", "Five"]

print("Original array: \(array)")

let filteredArray = array.filter { (element) -> Bool in
    
    if element.range(of: "e") != nil {
        return true
    } else {
        return false
    }
}

print("Filtered array: \(filteredArray)")
// END array_filtering

//: [Next](@next)
