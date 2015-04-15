//
//  Grid.swift
//  Grid
//
//  Created by Jon Manning on 13/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN grid
// A GridPoint is a structure that represents a location in the grid.
// This is Hashable, because it will be stored in a dictionary.
struct GridPoint : Hashable {
    var x: Int;
    var y: Int;
    
    // Returns a unique number that represents this location.
    var hashValue: Int {
        get {
            return x ^ (y << 32)
        }
    }
    
    
}

// If an object is Hashable, it's also Equatable. To conform
// to the requirements of the Equatable protocol, you need
// to implement the == operation (which returns true if two objects
// are the same, and false if they aren't
func ==(first : GridPoint, second : GridPoint) -> Bool {
    return first.x == second.x && first.y == second.y
}

// Next: the grid itself
class Grid: NSObject {
    
    // The information is stored as a dictionary mapping
    // GridPoints to arrays of NSObjects
    var contents: [GridPoint: [NSObject]] = [:]
    
    // Returns the list of objects that occupy the given position
    func objectsAtPosition(position: GridPoint) -> [AnyObject] {
        
        // If we have a collection of objects at this position, return it
        if let objects = self.contents[position] {
            return objects
        } else {
            // Otherwise, create an empty collection
            self.contents[position] = []
            // And return it
            return []
        }
        
    }
    
    // Returns a GridPoint describing the position of an object, if it exists
    func positionForObject(objectToFind: NSObject) -> GridPoint? {
        
        for (position, objects) in contents {
            
            if find(objects, objectToFind) != nil {
                return position
            }
            
        }
        
        return nil
        
    }
    
    // Adds or move the object to a location on the board
    func addObject(object: NSObject, atPosition position: GridPoint) {
        
        if self.contents[position] == nil {
            self.contents[position] = []
        }
        
        self.contents[position]?.append(object)
        
    }
    
    // Removes a given object from the board
    func removeObjectFromGrid(objectToRemove : NSObject) {
        
        var newContents = self.contents
        
        for (position, objects) in contents {
            newContents[position] = newContents[position]?.filter
            { (item) -> Bool in
                return item != objectToRemove
            }
        }
        self.contents = newContents
    }
    
    // Removes all objects at a given point from the board
    func removeAllObjectsAtPosition(position: GridPoint) {
        self.contents[position] = []
    }
    
    // Removes all objects from the board.
    func removeAllObjects() {
        self.contents = [:]
    }
    
}
// END grid


