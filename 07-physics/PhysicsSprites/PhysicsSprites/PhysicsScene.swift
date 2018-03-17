//
//  PhysicsScene.swift
//  PhysicsSprites
//
//  Created by Jon Manning on 16/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import SpriteKit

class PhysicsScene: SKScene {
    
    
    override init(size: CGSize) {
        
        
        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        
        self.createPhysicsSprite()
        self.createStaticPhysicsSprite()
        self.createCircularSprite()
        self.createPolygonSprite()
        
        self.createWalls()
        
        self.createEdgeSprite()
        
        self.createCustomMassSprite()
        
        // BEGIN searching_for_bodies
        let searchRect = CGRect(x: 10, y: 10, width: 200, height: 200)
        
        self.physicsWorld.enumerateBodies(in: searchRect) {(body, stop) in
            print("Found a body: \(body)")
        }
        
        let searchPoint = CGPoint(x: 40, y: 100)
        
        self.physicsWorld.enumerateBodies(at: searchPoint) { (body, stop) in
            print("Found a body: \(body)")
        }
        
        let searchRayStart = CGPoint(x: 0, y: 0)
        let searchRayEnd = CGPoint(x: 320, y: 480)
        
        self.physicsWorld.enumerateBodies(alongRayStart: searchRayStart, end: searchRayEnd) { (body, point, normal, stop) in
            print("Found a body: \(body) (point: \(point), normal: \(normal))")
        }
        // END searching_for_bodies
        
        // BEGIN stop_enumerating
        // Stop when we've found two bodies
        var count : Int = 0
        self.physicsWorld.enumerateBodies(in: searchRect) { (body, stop) in
            count = count + 1
            
            if count >= 2 {
                stop.initialize(to: true)
            }
        }
        // END stop_enumerating
        
        
        
        // BEGIN first_body
        let firstBodyAtPoint = self.physicsWorld.body(at: searchPoint)
        
        let firstBodyInRect = self.physicsWorld.body(in: searchRect)
        
        let firstBodyAlongRay =
            self.physicsWorld.body(alongRayStart: searchRayStart, end:searchRayEnd)
        // END first_body
        
        // BEGIN half_gravity
        // Half gravity
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -4.5)
        // END half_gravity
        
        // BEGIN zero_gravity
        // Zero gravity
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        // END zero_gravity
        
        // BEGIN reverse_gravity
        // Reverse gravity
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 9.81)
        // note the lack of a minus symbol
        // END reverse_gravity
        
        // BEGIN physics_speed
        self.physicsWorld.speed = 2.0
        
        self.physicsWorld.speed = 0.0
        
        self.physicsWorld.speed = 1.0
        // END physics_speed
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Not implemented")
        return nil
    }
    
    
    func createWalls() {
        
        let scene = self
        
        // BEGIN walls
        let wallsNode = SKNode()
        wallsNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        let rect = self.frame.offsetBy(
            dx: -self.frame.width / 2.0,
            dy: -self.frame.height / 2.0
        )
        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFrom:rect)
        
        scene.addChild(wallsNode)
        // END walls
        
    }
    
    func createEdgeSprite() {
        
        // BEGIN edge_chain
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -50, y:-10))
        path.addLine(to: CGPoint(x: -25, y:10))
        path.addLine(to: CGPoint(x: 0, y:-10))
        path.addLine(to: CGPoint(x: 25, y:10))
        path.addLine(to: CGPoint(x: 50, y:-10))
        
        let wallNode = SKShapeNode()
        wallNode.path = path.cgPath
        wallNode.physicsBody = SKPhysicsBody(edgeChainFrom: path.cgPath)
        wallNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY-50)
        // END edge_chain
        
        self.addChild(wallNode)
        
        
        // BEGIN single_edge
        let point1 = CGPoint(x: -50, y: 0)
        let point2 = CGPoint(x: 50, y: 0)
        
        let edgeBody = SKPhysicsBody(edgeFrom: point1, to: point2)
        // END single_edge
        
    }
    
    func createPhysicsSprite() {
        
        let scene = self
        
        // BEGIN physics_sprite
        // 'scene' is an SKScene
        
        let sprite = SKSpriteNode(color:SKColor.white,
                                  size:CGSize(width: 100, height: 50))
        sprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        sprite.physicsBody = SKPhysicsBody(rectangleOf:sprite.size)
        
        scene.addChild(sprite)
        // END physics_sprite
        
        
        // BEGIN setting_velocity
        // Start moving upwards at 500 units per second (quite fast!)
        sprite.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        // END setting_velocity
        
        // BEGIN affected_by_gravity
        sprite.physicsBody?.affectedByGravity = false
        // END affected_by_gravity
        
        // BEGIN allow_rotation
        sprite.physicsBody?.allowsRotation = true
        // END allow_rotation
        
    }
    
    func createCustomMassSprite() {
        let sprite = SKSpriteNode(color:SKColor.white, size:CGSize(width: 100, height: 50))
        sprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 500);
        self.addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(rectangleOf:sprite.size)
        
        // BEGIN mass
        // Change density, and the mass will be updated (based on size)
        sprite.physicsBody?.density = 2.0
        
        // Alternatively, set the mass property (which will change density)
        sprite.physicsBody?.mass = 4.0
        // END mass
    }
    
    func createStaticPhysicsSprite() {
        
        let scene = self
        
        // BEGIN static_physics
        let staticSprite = SKSpriteNode(color:SKColor.yellow,
                                        size:CGSize(width: 200, height: 25))
        
        staticSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        staticSprite.physicsBody = SKPhysicsBody(rectangleOf:staticSprite.size)
        staticSprite.physicsBody?.isDynamic = false
        
        
        scene.addChild(staticSprite)
        // END static_physics
    }
    
    func createCircularSprite() {
        
        let scene = self
        
        
        // BEGIN circle_sprite
        let circleSprite = SKShapeNode()
        let ovalRect: CGRect = CGRect(x: -50, y: -50, width: 100, height: 100)
        circleSprite.path =
            UIBezierPath(ovalIn:ovalRect).cgPath
        
        circleSprite.lineWidth = 1
        circleSprite.physicsBody = SKPhysicsBody(circleOfRadius:50)
        circleSprite.position =
            CGPoint(x: self.frame.midX+40, y: self.frame.midY + 100)
        
        self.addChild(circleSprite)
        // END circle_sprite
        
    }
    
    func createPolygonSprite() {
        // BEGIN polygon_sprite
        let polygonSprite = SKShapeNode()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -25, y: -25))
        path.addLine(to: CGPoint(x: 25, y: 0))
        path.addLine(to: CGPoint(x: -25, y: 25))
        path.close()
        
        polygonSprite.physicsBody = SKPhysicsBody(polygonFrom:path.cgPath)
        // END polygon_sprite
        
        polygonSprite.path = path.cgPath
        polygonSprite.lineWidth = 1
        polygonSprite.position = CGPoint(x: self.frame.midX-20, y: self.frame.midY + 100)
        
        self.addChild(polygonSprite)
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
