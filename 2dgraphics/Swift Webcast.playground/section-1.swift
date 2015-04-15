// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol SecuritySystem {
    func deploySystem() -> Void
}

class GuardDog : SecuritySystem {
    var name = "Rex"
    func deploySystem() {
        println("Release the hounds!")
    }
}

class SleepingGas : SecuritySystem {
    var sleepiness = 4.0
    func deploySystem() {
        println("Release the sleeping gas!")
    }
}

class House {
    var wallColour : UIColor = UIColor.whiteColor()
    
    var securitySystem : SecuritySystem?
}

var myHouse = House()
myHouse.securitySystem = GuardDog()
myHouse.securitySystem?.deploySystem()

1 == 1
(2 + 2) >= 5

1.description

struct Horse {
    var horsePower : Int = 5
}

extension Horse : Printable {
    var description : String {
        get {
            var s = "n"
            for i in 1...horsePower {
                s += "e"
            }
            s += "igh"
            return s
        }
    }
}

var myHorse = Horse()
myHorse.description

extension Horse : Equatable {}

func ==(left: Horse, right:Horse) -> Bool {
    return left.horsePower == right.horsePower
}

var myOtherHorse = Horse(horsePower: 4)
myHorse == myOtherHorse

extension Horse : Comparable {}

func <(left:Horse, right:Horse) -> Bool {
    return left.horsePower < right.horsePower
}

prefix func !(left: Horse) -> Horse {
    return Horse(horsePower: -left.horsePower)
}

!myHorse

myHorse < myOtherHorse
myOtherHorse >= myHorse

func areValuesEqual<T:Equatable>(first : T, second: T) -> Bool {
    return first == second
}

areValuesEqual(2,2)

areValuesEqual(1.0, 1.0)

areValuesEqual([1,2], [1,2])

class Tree <T> {
    
    var data : T
    var childNodes : [Tree<T>] = []
    
    init(data: T) {
        self.data = data
    }
    
    func addChildNode(dataToAdd: T) -> Tree<T> {
        let newNode = Tree<T>(data: dataToAdd)
        childNodes.append(newNode)
        return newNode
    }
    
}

var topLevelNode = Tree<Int>(data: 2)

let secondLevelNode = topLevelNode.addChildNode(4)

var myStringTree = Tree<String>(data: "Hello")

func addNumbers(first: Int, second: Int) -> Int {
    return first + second
}

var numbersFunc : (Int, Int) -> Int

numbersFunc = addNumbers

numbersFunc(2,2)

var addThree = { (firstNumber : Int) -> Int in
    return firstNumber + 3
}

func doSomethingWithNumber(number: Int, thingToDo: Int -> Int) -> Int {
    return thingToDo(number)
}

doSomethingWithNumber(4, addThree)

func makeCounter(step: Int) -> Void -> Int {
    var count = 0
    
    var counter = { () -> Int in
        count += step
        return count
    }
    
    return counter
}

var countByFives = makeCounter(5)

countByFives()
countByFives()

var countByTens = makeCounter(10)

countByTens()
countByTens()

var array = [1,6,2,7]

array.sorted {
    $0 < $1
}

1 + 2
!true

var foo = 1
foo++

postfix operator ~~ { }

postfix func ~~(item: Int) -> Int {
    return item * 2
}

2~~

postfix func ~~(item: String) -> String {
    return item + " " + item
}

"Hello"~~

prefix operator √ {}

prefix func √(item: Int) -> Float {
    return sqrtf(Float(item))
}

√4

infix operator --- { associativity left precedence 140 }

var a = 1

extension Int : NilLiteralConvertible {
    public init(nilLiteral: ()) {
        self = 0
    }
}

a = nil

extension Int : ArrayLiteralConvertible {
    public init(arrayLiteral elements: Int...) {
        self = elements.reduce(0, combine: +)
    }
}

final class Foo {
    
}

extension Foo : Equatable {
    
}

func == (left: Foo, right: Foo) -> Bool {
    return true
}


a = [1,2,3]













