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
        
        let rect = self.frame.offsetBy(dx: -self.frame.width / 2.0,
                                       dy: -self.frame.height / 2.0)
        
        
        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFrom:rect)
        
        self.addChild(wallsNode)
        
        // Add some boxes
        for _ in 1...4 {
            let box = SKSpriteNode(color:SKColor.red,
                                   size:CGSize(width: 50, height: 50))
            
            box.physicsBody = SKPhysicsBody(rectangleOf:box.size)
            box.position = CGPoint(x: self.frame.midX,
                                   y: self.frame.midY)
            self.addChild(box)
        }
        
        // Only allow a single touch at a time
        self.view?.isMultipleTouchEnabled = false
    }
    
    // BEGIN dragging
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        
        // We only care about one touch at a time
        
        // Ensure we have a touch to work with
        guard let touch = touches.first else {
            return
        }
        
        // Work out what node got touched
        let touchPosition = touch.location(in: self)
        let touchedNode = self.atPoint(touchPosition)
        
        // Make sure that we're touching something that _can_ be dragged
        guard let touchedPhysicsBody = touchedNode.physicsBody else {
                return
        }
        
        // Create the invisible drag node, with a small static body
        let newDragNode = SKNode()
        newDragNode.position = touchPosition
        
        let dragPhysicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 10,
                                                               height: 10))
        dragPhysicsBody.isDynamic = false
        newDragNode.physicsBody = dragPhysicsBody
        
        self.addChild(newDragNode)
        
        // Link this new node to the object that got touched
        let newDragJoint = SKPhysicsJointPin.joint(
            withBodyA: touchedPhysicsBody,
            bodyB:dragPhysicsBody,
            anchor:touchPosition)
        
        self.physicsWorld.add(newDragJoint)
        
        // Store the reference to the joint and the node
        self.dragNode = newDragNode
        self.dragJoint = newDragJoint
        
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        // When the touch moves, move the static drag node.
        // The joint will drag the connected
        // object with it.
        let touchPosition = touch.location(in: self)
        
        dragNode?.position = touchPosition
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        stopDragging()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        stopDragging()
    }
    
    func stopDragging() {
        
        guard dragJoint != nil else {
            return
        }
        
        // Remove the joint and the drag node.
        self.physicsWorld.remove(dragJoint!)
        dragJoint = nil
        
        dragNode?.removeFromParent()
        dragNode = nil
    }
    // END dragging
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
