//: [Previous](@previous)

import Foundation
import XCTest

class SomeAwesomeObject {
    func doSomethingCool() -> Bool {
        return true
    }
}

// BEGIN tests
func testDoingSomethingCool() {
    
    let object = SomeAwesomeObject()
    
    let succeeded = object.doSomethingCool()
    
    if succeeded == false {
        XCTFail("Failed to do something cool");
    }
}
// END tests

var X : String? = nil

// Fails if X is not nil
XCTAssertNil(X, "X should be nil")

X = "hello"

// Fails if X IS nil
XCTAssertNotNil(X, "X should not be nil")

// Fails if X is not true
XCTAssertTrue(1 == 1, "1 really should be equal to 1")

// Fails if X is not false
XCTAssertFalse(2 == 3, "In this universe, 2 equals 3 apparently")

// Fails if X and Y are not equal (tested by calling X.equals(Y)])
XCTAssertEqual((2), (1+1), "Objects should be equal")

// Fails if X and Y ARE equal (tested by calling X.equals(Y))
XCTAssertNotEqual("One", "1", "Objects should not be equal")

// Fails, regardless of circumstances
XCTFail("Everything is broken")

//: [Next](@next)
