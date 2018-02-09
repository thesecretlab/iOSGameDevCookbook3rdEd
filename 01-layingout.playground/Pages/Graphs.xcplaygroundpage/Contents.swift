//: [Previous](@previous)

import Foundation

import GameplayKit

// BEGIN grids_gridnode
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
// END grids_gridnode

// BEGIN grids_create_graph
let graph = GKGridGraph<GameNode>(fromGridStartingAt: [0,0], width: 6, height: 6, diagonalsAllowed: false)
// END grids_create_graph

// BEGIN grids_replace_node
func add<NodeType>(node: NodeType, to graph: GKGridGraph<NodeType>) {
    
    // If there's a node at this position here already, remove it
    if let existingNode = graph.node(atGridPosition: node.gridPosition) {
        graph.remove([existingNode])
    }
    
    // Add the new node, and connect it to the other nodes on the graph
    graph.connectToAdjacentNodes(node: node)
}
// END grids_replace_node

// BEGIN grids_replace_node_usage
// Add two
let playerNode = GameNode(name: "Player", gridPosition: [0,2])
let exitNode   = GameNode(name: "Exit", gridPosition: [0,3])

add(node: playerNode, to: graph)
add(node: exitNode, to: graph)
// END grids_replace_node_usage

// BEGIN grids_get_at_position
graph.node(atGridPosition: [0,2])?.name // "Player"
// END grids_get_at_position

// BEGIN grids_get_all
// Get all GameNodes on the grid of a certain type
let allNodes = graph.nodes?.filter { $0 is GameNode }
// END grids_get_all

//: [Next](@next)
