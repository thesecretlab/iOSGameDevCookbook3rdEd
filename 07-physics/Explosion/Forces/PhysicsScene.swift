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
        
        // Add 50 small boxes
        
        for _ in 0...50 {
            let node = SKSpriteNode(color:SKColor.white, size:CGSize(width: 20, height: 20))
            node.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            node.physicsBody = SKPhysicsBody(rectangleOf:node.size)
            node.physicsBody?.density = 0.01
            
            self.addChild(node)
        }
        
        // Add the walls
        let walls = SKNode()
        walls.physicsBody = SKPhysicsBody(edgeLoopFrom:self.frame)
        self.addChild(walls)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
        
            
            // BEGIN create_explosion
            // 'point' is a CGPoint in world space
            self.applyExplosion(at: point, radius:150, power:10)
            // END create_explosion
        }
    }
    
    
// BEGIN apply_explosion
func applyExplosion(at point: CGPoint,
    radius:CGFloat, power:CGFloat) {
    
    // Work out which bodies are in range of the explosion
    // by creating a rectangle
    let explosionRect = CGRect(x: point.x - radius,
        y: point.y - radius,
        width: radius*2, height: radius*2)
        
    // For each body, apply an explosion force
    self.physicsWorld.enumerateBodies(in: explosionRect,
                                      using:{ (body, stop) in

        // Work out if the body has a node that we can use
        if let bodyPosition = body.node?.position {
                
            // Work out the direction that we should apply
            // the force in for this body
            // BEGIN explosion_offset
            let explosionOffset =
                CGVector(dx: bodyPosition.x - point.x,
                dy: bodyPosition.y - point.y)
            // END explosion_offset
                
            // Work out the distance from the explosion point
            // BEGIN explosion_distance
            let explosionDistance =
                sqrt(explosionOffset.dx * explosionOffset.dx +
                    explosionOffset.dy * explosionOffset.dy)
            // END explosion_distance
                
            // BEGIN create_force
            // Normalize the explosion force
            var explosionForce = explosionOffset
            explosionForce.dx /= explosionDistance
            explosionForce.dy /= explosionDistance
                
            // Multiply by explosion power
            explosionForce.dx *= power
            explosionForce.dy *= power
            // END create_force
                
            // Finally, apply the force
            // BEGIN apply_force
            body.applyForce(explosionForce)
            // END apply_force
        }
    })
            
}
// END apply_explosion
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
