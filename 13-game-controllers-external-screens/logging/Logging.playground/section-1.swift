// Playground - noun: a place where people can play

import UIKit

// BEGIN log
func Log(message: String,
    file: String = __FILE__,
    line : Int = __LINE__,
    function: String = __FUNCTION__) {
        
    NSLog("\(function) (\(file.lastPathComponent):\(line)): \(message)")
        
}
// END log


Log("Hi")
