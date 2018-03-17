// Playground - noun: a place where people can play

import UIKit

// BEGIN math_position
let myPosition = CGPoint(x: 2, y: 2)
// END math_position

// BEGIN math_vector
let myVector = CGVector(dx: 2, dy: 3)
// END math_vector

// BEGIN math_vector_length
let length = sqrt(myVector.dx * myVector.dx + myVector.dy * myVector.dy)
// length = 3.60555127546399
// END math_vector_length

// BEGIN math_vector_length_extension
// Add a read-only property called 'length' to all CGVectors
extension CGVector {
    var length : Double {
        
        get {
            let dx = Double(self.dx)
            let dy = Double(self.dy)
            
            return sqrt(dx * dx +
                        dy * dy)
        }
    }
}

// Use it like this:
print(myVector.length)
// END math_vector_length_extension

// BEGIN math_adding_vectors
let vector1 = CGVector(dx: 1, dy: 2)
let vector2 = CGVector(dx: 1, dy: 1)

let combinedVector = CGVector(dx: vector1.dx + vector2.dx,
                              dy: vector1.dy + vector2.dy)

// combinedVector = [2, 3]
// END math_adding_vectors

// BEGIN math_adding_vector_operator
// Note: this function, like other operator functions,
// needs to be at the top level, and not in a class or extension
func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx,
                    dy: left.dy + right.dy)
}

// Can now directly add using +:
let vectorAdding = vector1 + vector2
// = [2, 3]
// END math_adding_vector_operator

if true {
// BEGIN math_radians_to_degrees
let radians = 3.14159
let degrees = radians * 180.0 / .pi
// degrees ~= 180.0
// END math_radians_to_degrees
}

if true {
// BEGIN math_degrees_to_radians
let degrees = 45.0
let radians = degrees * .pi / 180.0
// radians ~= 0.7854
// END math_degrees_to_radians
}

// BEGIN math_rotation
let angle : Float = .pi / 4.0 // = 45 degrees

let point = CGPoint(x: 4, y: 4)

let x = Float(point.x)
let y = Float(point.y)

var rotatedPoint : CGPoint = point
rotatedPoint.x = CGFloat(x * cosf(angle) - y * sinf(angle))
rotatedPoint.y = CGFloat(y * cosf(angle) + x * sinf(angle))
print(rotatedPoint)
// rotatedPoint = (0, 6.283)
// END math_rotation


// BEGIN math_scale
var scaledVector = CGVector(dx: 2, dy: 7)
scaledVector.dx *= 4
scaledVector.dy *= 4

// scaledVector = [8, 28]
// END math_scale

// BEGIN math_dotproduct
let v1 = CGPoint(x: 2, y: 2)
let v2 = CGPoint(x: 2, y: 1)

let dotProduct = (v1.x * v2.x + v1.y * v2.y)
// END math_dotproduct

// BEGIN math_dotproduct_operator

// Declare the operator as having left associativity
// and the same level of precedence as the + operator
infix operator •
// (Typing Tip™: Press Option-8 to type the • character)

// Define what the • operator actually does
func • (left : CGPoint, right : CGPoint) -> Double {
    return Double(left.x * right.x + left.y * right.y)
}

// Use it like so:
v1 • v2
// END math_dotproduct_operator






