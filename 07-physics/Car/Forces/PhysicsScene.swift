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
        
        let rect = self.frame.offsetBy(dx: -self.frame.width / 2.0, dy: -self.frame.height / 2.0)
        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFrom:rect)
        
        self.addChild(wallsNode)
        
        _ = self.createCar()
        
    }
    
// BEGIN car
func createWheel(radius: CGFloat) -> SKShapeNode {
    let wheelRect = CGRect(x: -radius, y: -radius,
        width: radius*2, height: radius*2)
        
    let wheelNode = SKShapeNode()
    wheelNode.path = UIBezierPath(ovalIn: wheelRect).cgPath
        
    return wheelNode
}
    
func createCar() -> SKNode {
        
    // Create the car
    let carNode = SKSpriteNode(color:SKColor.yellow,
        size:CGSize(width: 150, height: 50))
    let carPhysicsBody = SKPhysicsBody(rectangleOf:carNode.size)
    carNode.physicsBody = carPhysicsBody
    
    carNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
    self.addChild(carNode)
        
    // Create the left wheel
    let leftWheelNode = self.createWheel(radius: 30)
    let leftWheelPhysicsBody = SKPhysicsBody(circleOfRadius:30)
    leftWheelNode.physicsBody = leftWheelPhysicsBody
    leftWheelNode.position = CGPoint(x: carNode.position.x-80,
        y: carNode.position.y)
    self.addChild(leftWheelNode)
        
    // Create the right wheel
    let rightWheelNode = self.createWheel(radius: 30)
    let rightWheelPhysicsBody = SKPhysicsBody(circleOfRadius:30)
    rightWheelNode.physicsBody = rightWheelPhysicsBody
    rightWheelNode.position = CGPoint(x: carNode.position.x+80,
        y: carNode.position.y)
    self.addChild(rightWheelNode)
        
    // Attach the wheels to the body
    let leftWheelPosition = leftWheelNode.position
    let rightWheelPosition = rightWheelNode.position
        
    let leftPinJoint = SKPhysicsJointPin.joint(withBodyA: carPhysicsBody,
        bodyB:leftWheelPhysicsBody, anchor:leftWheelPosition)
    let rightPinJoint = SKPhysicsJointPin.joint(withBodyA: carPhysicsBody,
        bodyB:rightWheelPhysicsBody, anchor:rightWheelPosition)
        
    self.physicsWorld.add(leftPinJoint)
    self.physicsWorld.add(rightPinJoint)
        
    return carNode
}
// END car
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
