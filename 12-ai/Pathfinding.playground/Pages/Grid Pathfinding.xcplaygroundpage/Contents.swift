//: Playground - noun: a place where people can play

import UIKit

// BEGIN grid_pathfinding
import GameplayKit

// Define an 8x8 grid
let grid = GKGridGraph(fromGridStartingAt: [0,0],
                       width: 8, height: 8,
                       diagonalsAllowed: false)

// Remove a chunk of nodes from the middle of the grid,
// so that our path is a little more interesting
let nodesToRemove = (1...7).map {
    return grid.node(atGridPosition: [3, $0])!
}
grid.remove(nodesToRemove)

// Find a path from the top-left corner to the bottom-right
let startNode = grid.node(atGridPosition: [0,0])!
let destinationNode = grid.node(atGridPosition: [7,7])!

let path = grid.findPath(
    from: startNode,
    to: destinationNode
    ) as! [GKGridGraphNode]

// Print out the path
print("Path found:")
for point in path {
    print(point.gridPosition)
}
// END grid_pathfinding

