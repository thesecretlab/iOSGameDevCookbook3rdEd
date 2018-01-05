//
//  GameScene.swift
//  Forces
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

class PhysicsScene: SKScene {
    
    var dragNode : SKNode?
    var dragJoint : SKPhysicsJointPin?

    override init(size: CGSize) {
        super.init(size: size)
        
        // Add some walls
        let wallsNode = SKNode()
        wallsNode.position = CGPoint(x: self.frame.midX,
            y: self.frame.midY)
        
        let rect = CGRectOffset(self.frame,
            -self.frame.width / 2.0, -self.frame.height / 2.0)
        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFromRect:rect)
        
        self.addChild(wallsNode)

        // Add some boxes
        for i in 1...4 {
            let box = SKSpriteNode(color:SKColor.redColor(),
                size:CGSize(width: 50, height: 50))
            
            box.physicsBody = SKPhysicsBody(rectangleOfSize:box.size)
            box.position = CGPoint(x: self.frame.midX,
                y: self.frame.midY)
            self.addChild(box)
        }
        
        // Only allow a single touch at a time
        self.view?.multipleTouchEnabled = false
    }
    
// BEGIN dragging
override func touchesBegan(touches: Set<NSObject>,
    withEvent event: UIEvent) {
        
    // We only care about one touch at a time
    if let touch = touches.first as? UITouch {
            
        // Work out what node got touched
        let touchPosition = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchPosition)
            
        // Make sure that we're touching something that _can_ be dragged
        if touchedNode == dragNode || touchedNode.physicsBody == nil {
            return
        }
            
        // Create the invisible drag node, with a small static body
        let newDragNode = SKNode()
        newDragNode.position = touchPosition
        newDragNode.physicsBody =
            SKPhysicsBody(rectangleOfSize:CGSize(width: 10,
                                                 height: 10))
        newDragNode.physicsBody?.dynamic = false
            
        self.addChild(newDragNode)
            
        // Link this new node to the object that got touched
        let newDragJoint = SKPhysicsJointPin.jointWithBodyA(
            touchedNode.physicsBody,
            bodyB:newDragNode.physicsBody,
            anchor:touchPosition)
            
        self.physicsWorld.addJoint(newDragJoint)
            
        // Store the reference to the joint and the node
        self.dragNode = newDragNode
        self.dragJoint = newDragJoint
            
    }
}
    
override func touchesMoved(touches: Set<NSObject>,
    withEvent event: UIEvent) {
            
    if let touch = touches.first as? UITouch {
        // When the touch moves, move the static drag node.
        // The joint will drag the connected
        // object with it.
        let touchPosition = touch.locationInNode(self)
            
        dragNode?.position = touchPosition
    }
}
    
override func touchesEnded(touches: Set<NSObject>,
    withEvent event: UIEvent) {
            
    stopDragging()
}
    
override func touchesCancelled(touches: Set<NSObject>,
    withEvent event: UIEvent) {
            
    stopDragging()
}
    
func stopDragging() {
    // Remove the joint and the drag node.
    self.physicsWorld.removeJoint(dragJoint!)
    dragJoint = nil
        
    dragNode?.removeFromParent()
    dragNode = nil
}
// END dragging

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
