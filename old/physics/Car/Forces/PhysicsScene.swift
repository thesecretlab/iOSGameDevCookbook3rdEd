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
        super.init(size: size)
        
        // Add some walls
        let wallsNode = SKNode()
        wallsNode.position = CGPoint(x: self.frame.midX,
            y: self.frame.midY)
        
        let rect = CGRectOffset(self.frame,
            -self.frame.width / 2.0, -self.frame.height / 2.0)
        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFromRect:rect)
        
        self.addChild(wallsNode)
        
        let car = self.createCar()
        
    }
    
// BEGIN car
func createWheel(wheelRadius: CGFloat) -> SKShapeNode {
    let wheelRect = CGRect(x: -wheelRadius, y: -wheelRadius,
        width: wheelRadius*2, height: wheelRadius*2)
        
    let wheelNode = SKShapeNode()
    wheelNode.path = UIBezierPath(ovalInRect: wheelRect).CGPath
        
    return wheelNode
}
    
func createCar() -> SKNode {
        
    // Create the car
    let carNode = SKSpriteNode(color:SKColor.yellowColor(),
        size:CGSize(width: 150, height: 50))
    carNode.physicsBody = SKPhysicsBody(rectangleOfSize:carNode.size)
    carNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
    self.addChild(carNode)
        
    // Create the left wheel
    let leftWheelNode = self.createWheel(30)
    leftWheelNode.physicsBody = SKPhysicsBody(circleOfRadius:30)
    leftWheelNode.position = CGPoint(x: carNode.position.x-80,
        y: carNode.position.y)
    self.addChild(leftWheelNode)
        
    // Create the right wheel
    let rightWheelNode = self.createWheel(30)
    rightWheelNode.physicsBody = SKPhysicsBody(circleOfRadius:30)
    rightWheelNode.position = CGPoint(x: carNode.position.x+80,
        y: carNode.position.y)
    self.addChild(rightWheelNode)
        
    // Attach the wheels to the body
    let leftWheelPosition = leftWheelNode.position
    let rightWheelPosition = rightWheelNode.position
        
    let leftPinJoint = SKPhysicsJointPin.jointWithBodyA(carNode.physicsBody,
        bodyB:leftWheelNode.physicsBody, anchor:leftWheelPosition)
    let rightPinJoint = SKPhysicsJointPin.jointWithBodyA(carNode.physicsBody,
        bodyB:rightWheelNode.physicsBody, anchor:rightWheelPosition)
        
    self.physicsWorld.addJoint(leftPinJoint)
    self.physicsWorld.addJoint(rightPinJoint)
        
    return carNode
}
// END car
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
