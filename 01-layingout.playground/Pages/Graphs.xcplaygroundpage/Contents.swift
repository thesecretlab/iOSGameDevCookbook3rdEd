//: [Previous](@previous)

import Foundation

import GameplayKit

class GameNode : GKGridGraphNode {
    var name : String
    
    init (name: String, gridPosition: vector_int2) {
        self.name = name
        super.init(gridPosition: gridPosition)
    }
    
    override var description: String {
        return self.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}

let graph = GKGridGraph<GameNode>(fromGridStartingAt: [0,0], width: 6, height: 6, diagonalsAllowed: false)

func add<NodeType>(node: NodeType, to graph: GKGridGraph<NodeType>) {
    
    // If there's a node at this position here already, remove it
    if let existingNode = graph.node(atGridPosition: node.gridPosition) {
        graph.remove([existingNode])
    }
    
    // Add the new node, and connect it to the other nodes on the graph
    graph.connectToAdjacentNodes(node: node)
}

// Add two
let playerNode = GameNode(name: "Player", gridPosition: [0,2])
let exitNode   = GameNode(name: "Exit", gridPosition: [0,3])

add(node: playerNode, to: graph)
add(node: exitNode, to: graph)

graph.node(atGridPosition: [0,2])?.name // "Player"

// Get all GameNodes on the grid
let x = graph.nodes?.filter { $0 is GameNode }.count

//: [Next](@next)
