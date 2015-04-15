//
//  Navigation.swift
//  Behaviours
//
//  Created by Jon Manning on 17/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import Foundation
import UIKit

// BEGIN a_star
// Add support for storing CGPoints inside dictionaries, so that
// our code can be nice and elegant
extension CGPoint : Hashable {
    public var hashValue : Int {
        // Derive the hash by using hash values of 
        // the x and y components
        return self.x.hashValue << 32 ^ self.y.hashValue
    }
    
    // Also add a convenience function that calculates
    // how far away this point is from another
    public func distanceTo(other : CGPoint) -> CGFloat {
        return (self - other).length
    }
}

struct NavigationGrid {
    
    // The points that this structure knows about
    var points : [CGPoint]
    
    // For each point in self.points, a list of points
    // that are one 'hop' away
    var neighbors : [CGPoint : [CGPoint]]
    
    // When starting up, store the points we're given,
    // plus a list of neighbors for each node
    init (points:[CGPoint], maximumDistance: CGFloat) {
        
        self.points = points
        self.neighbors = [:]
        
        // Make a list of neighbors for each node and store that
        for point in self.points {
            
            // Start with an empty list
            self.neighbors[point] = []
            
            // Check all other points..
            for otherPoint in self.points {
                
                // (..except this current one)
                if point == otherPoint {
                    continue
                }
                
                // Add this point as a neighbor if it's within range
                if point.distanceTo(otherPoint) <= maximumDistance {
                    self.neighbors[point]?.append(otherPoint)
                }
            }
        }
        
    }
    
    // Find the nearest point in our collection of points
    func nearestPointToPoint(point : CGPoint) -> CGPoint {
        var nearestPointSoFar : CGPoint = self.points[0]
        var nearestDistanceSoFar = CGFloat.infinity
        
        for node in self.points {
            let distance = node.distanceTo(point)
            if distance < nearestDistanceSoFar {
                nearestDistanceSoFar = distance
                nearestPointSoFar = node
            }
        }
        
        return nearestPointSoFar
    }
    
    func pathTo(start: CGPoint, end:CGPoint) -> [CGPoint]? {
        
        // g-score of a node: the known length of the path
        // that reaches this node
        var gScores : [CGPoint : CGFloat] = [:]
        
        // f-score of a node: how important it is that we 
        // check this node (= g-score + distance from this 
        // point to goal); lower value means higher priority
        var fScores : [CGPoint : CGFloat] = [:]
        
        // Find the points in our collection that are closest
        // to where we've been asked to search from and to
        let startPoint = self.nearestPointToPoint(start)
        let goalPoint = self.nearestPointToPoint(end)
        
        // Closed nodes are nodes that we've checked
        var closedNodes = Set<CGPoint>()
        
        // Open nodes are nodes that we should check; the node
        // with the lowest f-score will be checked next
        var openNodes = Set<CGPoint>()
        
        // We begin the search at the start point
        openNodes.insert(startPoint)
        
        // Stores how we got from one node to another; used
        // to generate the final list of points once search
        // reaches the goal
        var cameFromMap : [CGPoint : CGPoint] = [:]
        
        // Keep searching for as long as we have points to check
        while openNodes.count > 0 {
            
            // Find the point with the lowest f-score
            // We do this by turning the set into an array,
            // then sorting it based on the f-score of each
            // item in the array, then taking the first item
            // in the resulting array
            let currentNode = Array(openNodes).sorted{
                (first, second) -> Bool in
                return fScores[first] < fScores[second]
            }.first!
            
            // If we are now looking at the goal point, we're 
            // done! Call reconstructPath to work backwards 
            // from the goal point, following the came-from 
            // map to get back to the start.
            if currentNode == goalPoint {
                return [start] + reconstructPath(cameFromMap,
                    currentNode: currentNode) + [end]
            }
            
            // Move this point from the open set to the closed set
            openNodes.remove(currentNode)
            closedNodes.insert(currentNode)
            
            let nodeNeighbors = self.neighbors[currentNode] ?? []
            
            // Examine each neighbor for this point
            for neighbor in nodeNeighbors {
                
                // Work out the scores for this node if it's
                // used in the path
                let tentativeGScore =
                    (gScores[currentNode] ?? 0.0)
                    + currentNode.distanceTo(neighbor)
                
                let tentativeFScore = tentativeGScore
                    + currentNode.distanceTo(goalPoint)
                
                // If this neighbor is in the closed set,
                // and using it would result in a worse
                // path, don't use it
                if closedNodes.contains(neighbor)
                    && tentativeFScore >=
                        (fScores[neighbor] ?? 0.0) {
                        continue
                }
                
                // If this neighbor is in the open set, OR
                // using it would result in a better path,
                // consider using it (by adding it to the
                // open set, so we possibly consider it next
                // iteration)
                if openNodes.contains(neighbor)
                    || tentativeFScore <
                        (fScores[neighbor] ?? CGFloat.infinity) {
                        
                        // Mark this neighbor on the path
                        // (indicating how we got to it)
                        cameFromMap[neighbor] = currentNode
                        
                        // Give this neighbor its score
                        fScores[neighbor] = tentativeFScore
                        gScores[neighbor] = tentativeGScore
                        
                        // Add this neighbor to the open set -
                        // depending on its f-score, it might
                        // be the next node we check!
                        openNodes.insert(neighbor)
                }
            }
        }
        
        // If we've run through the entire open set and 
        // still haven't found a path to the goal, it's 
        // unreachable; return nil to indicate that we 
        // found no path
        return nil
        
    }
    
    // Given a node and the came-from map, start working 
    // backwards until we reach the only node that has no 
    // came-from node (which is the start node)
    func reconstructPath(cameFromMap: [CGPoint:CGPoint],
        currentNode:CGPoint) -> [CGPoint] {
            
        if let nextNode = cameFromMap[currentNode] {
            return reconstructPath(cameFromMap,
                currentNode: nextNode) + [currentNode]
        } else {
            return [currentNode]
        }
    }
    
    
}
// END a_star