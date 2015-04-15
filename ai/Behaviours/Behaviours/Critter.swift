//
//  Critter.swift
//  Behaviours
//
//  Created by Jon Manning on 17/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import SpriteKit

// BEGIN vector_operators
/* Adding points together */
func + (left: CGPoint, right : CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right : CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func += (inout left: CGPoint, right: CGPoint) {
    left = left + right
}

func -= (inout left: CGPoint, right: CGPoint) {
    left = left + right
}

/* Working with scalars */

func + (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x + right, y: left.y + right)
}

func - (left: CGPoint, right: CGFloat) -> CGPoint {
    return left + (-right)
}

func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

func += (inout left: CGPoint, right: CGFloat) {
    left = left + right
}

func -= (inout left: CGPoint, right: CGFloat) {
    left = left - right
}

func *= (inout left: CGPoint, right: CGFloat) {
    left = left * right
}

func /= (inout left: CGPoint, right: CGFloat) {
    left = left / right
}
// END vector_operators

// BEGIN extension
extension CGPoint {
    var length :  CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
    
    var normalized : CGPoint {
        return self / length
    }
    
    func rotatedBy(radians : CGFloat) -> CGPoint {
        var rotatedPoint = CGPoint(x: 0, y: 0)
        rotatedPoint.x = self.x * cos(radians) - self.y * sin(radians)
        rotatedPoint.y = self.y * cos(radians) + self.x * sin(radians)
        
        return rotatedPoint        
    }
    
    func dot(other : CGPoint) -> CGFloat {
        return self.x * other.x + self.y * other.y
    }

    init (angleRadians : CGFloat) {
        self.x = sin(angleRadians)
        self.y = cos(angleRadians)
    }
    
    
}
// END extension

class Critter: SKSpriteNode {
    
    var movementSpeed = 100.0
    var turningSpeed = 10.0 / 180.0 * M_PI

    var target : Critter? = nil
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func moveToPosition(targetPosition: CGPoint, deltaTime: CGFloat) {
    
// BEGIN move_to_position
// Work out the direction to this position
var offset = self.position - targetPosition
        
// Reduce this vector to be the same length as our movement speed
offset = offset.normalized
offset *= CGFloat(self.movementSpeed) * deltaTime
        
// Add this to our current position
let newPosition = self.position + offset
        
self.position = newPosition;
// END move_to_position
    }
    
    func interceptTarget(target : Critter, deltaTime:CGFloat) {
        
// BEGIN intercept_target
let toTarget = target.position - self.position
                
let lookAheadTime = toTarget.length / CGFloat(self.movementSpeed
    + target.movementSpeed)
        
let destination = target.position
    + (CGFloat(target.movementSpeed) * lookAheadTime)
        
self.moveToPosition(destination, deltaTime:deltaTime)
// END intercept_target
    }
    
    func fleeFromTarget(target : Critter, deltaTime:CGFloat) {
        
// BEGIN flee_from_target
var offset = target.position - self.position
        
// Reduce this vector to be the same length as our movement speed
offset = offset.normalized
        
// Note the minus sign - we're multiplying by the reverse of our
// movement speed, which means we're moving away from it
offset *= CGFloat(-self.movementSpeed) * deltaTime
        
// Add this to our current position
let newPosition = self.position + offset
        
self.position = newPosition
// END flee_from_target
    }

    func findNearbyTarget() {
        let scene = self.scene;
        
// BEGIN find_target
var nearestNodeDistance = CGFloat.infinity
var nearestNode : Critter? = nil
        
// Find the nearest critter
scene?.enumerateChildNodesWithName("Critter") { (node, stop) -> Void in
    if let otherCritter = node as? Critter {
                
        if otherCritter == self {
            return
        }
                
        let distanceToTarget = (otherCritter.position - self.position).length
                
        if distanceToTarget < nearestNodeDistance {
            nearestNode = otherCritter
            nearestNodeDistance = distanceToTarget
        }
                
    }
}
        
self.target = nearestNode
// END find_target
        
    }

    func turnTowardsPosition(target:CGPoint, deltaTime:CGFloat) {
// BEGIN turn_to
// Work out the vector from our position to the target
let toTarget = target - self.position
        
// Work out our forward direction)
let forward = CGPoint(x: 0, y: 1).rotatedBy(self.zRotation)
        
// Get the angle needed to turn towards this position
var angle = toTarget.dot(forward)
angle /= acos(toTarget.length * forward.length)
        
// Clamp the angle to our turning speed
angle = min(angle, CGFloat(self.turningSpeed))
angle = max(angle, CGFloat(-self.turningSpeed))
        
// Apply the rotation
self.zRotation += angle * deltaTime
// END turn_to
        
    }

    func canSeeTarget(target: SKNode, fieldOfView: CGFloat, distance : CGFloat) -> Bool {
        
// BEGIN in_range
// Target is an SKNode,
// fieldOfView is a CGFloat,
// distance is a CGFloat

if (target.position - self.position).length > distance {
    return false
}
// END in_range

// BEGIN in_field_of_view
// BEGIN facing_direction
let facingDirection = CGPoint(x:0, y:1).rotatedBy(self.zRotation)
// END facing_direction
                
// BEGIN vector_to_target
let vectorToTarget = (target.position - self.position).normalized
// END vector_to_target
// BEGIN angle_to_target
let angleToTarget = acos(facingDirection.dot(vectorToTarget))
// END angle_to_target
        
return abs(angleToTarget) < fieldOfView / 2.0
// END in_field_of_view
    }

    
// BEGIN find_cover
func findPotentialCover(steps : Int, distance : CGFloat) -> [CGPoint] {
            
    // Start with an empty list
    var coverPoints : [CGPoint] = []
        
    // Step around the circle 'steps' times
    for coverPoint in 0..<steps {
            
        // Work out the angle at which we're considering
        let angle = Float(M_PI * 2.0) * (Float(coverPoint) / Float(steps))
            
        // Use that to create a point to check for cover
        let potentialPoint = CGPoint(angleRadians: CGFloat(angle)) * distance
            
        // Check to see if there's something between there and here
        if self.scene?.physicsWorld.bodyAlongRayStart(self.position,
            end: potentialPoint) != nil {
            // There's something between where we are and where we're
            // considering, so add this to the list
            coverPoints.append(potentialPoint)
        }
    }
        
    // Return the list of points that we found
    return coverPoints
}
// END find_cover

// BEGIN move_along_path
func moveAlongPath(points: [CGPoint]) {
        
    // If we've been given an empty path, do nothing
    if points.count == 0 {
        return
    }
        
    // Go through the list, and add an SKAction that moves from the previous
    // point to the current point
    var currentPoint = self.position
    var actions : [SKAction] = []
        
    for point in points {
        // Work out how long the movement should take, based on how
        // far away this point is and our movement speed
        let distance = (currentPoint - point).length
        let time = distance / CGFloat(self.movementSpeed)
            
        // Create a move-to action
        let moveToPoint = SKAction.moveTo(point, duration: NSTimeInterval(time))
        actions.append(moveToPoint)
            
        // Use this current point as the 'previous point' for the next step
        currentPoint = point
    }
        
    // Run all of these actions in sequence
    let sequence = SKAction.sequence(actions)
    self.runAction(sequence)
}
// END move_along_path
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
