//
//  Monster.swift
//  SavingState
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN coding
class Monster: Codable {
    
   
    // Game data
    var hitPoints = 0
    var name = "GameObject"
    
    // Initializer used when creating a brand new object
    init() {
        
    }

    // Initializer used when loading the object from data
    required init(coder aDecoder: NSCoder) {
    
        // BEGIN encode_int
        self.hitPoints = aDecoder.decodeInteger(forKey: "hitPoints")
        // END encode_int
        
        // Attempt to get the object with key "name" as a string;
        // if we can't convert it to a string or it doesn't exist,
        // fall back to "No Name"
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? "No Name"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.hitPoints, forKey: "hitPoints")
    }

    
}
// END coding

