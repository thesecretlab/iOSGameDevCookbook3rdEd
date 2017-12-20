//
//  GameScene.swift
//  Forces
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

class PhysicsScene: SKScene {

    override init(size: CGSize) {
        super.init(size:size)
        self.backgroundColor = SKColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        
        // Add the sprite
        let sprite = SKSpriteNode(color:SKColor.whiteColor(), size:CGSize(width: 100, height: 100))
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize:sprite.size)
        sprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        sprite.physicsBody?.density = 0.01
        
        sprite.name = "Box"
        
        self.addChild(sprite)
        
        // Add the walls
        let walls = SKNode()
        walls.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.addChild(walls)
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

        if let node = self.childNodeWithName("Box") {
            
// BEGIN apply_forces
node.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
node.physicsBody?.applyTorque(0.01)
// END apply_forces

            /*
// BEGIN apply_force_at_point
// Apply a force just to the right of the center of the body
let position = CGPoint(x: 10, y: 0)
node.physicsBody?.applyForce(CGVector(dx: 0, dy: 100), atPoint: position)
// END apply_force_at_point
            */

        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
