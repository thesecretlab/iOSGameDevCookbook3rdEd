//: [Previous](@previous)

import Foundation

// BEGIN componentbased_gameplaykit_import
import GameplayKit
// END componentbased_gameplaykit_import


// BEGIN componentbased_gameplaykit_componentclasses
// Two example components
class GraphicsComponent : GKComponent {
    override func update(deltaTime seconds: TimeInterval) {
        print("Drawing graphics!")
    }
}

class PhysicsComponent : GKComponent {
    override func update(deltaTime seconds: TimeInterval) {
        print("Simulating physics!")
    }
}
// END componentbased_gameplaykit_componentclasses

// Create some objects that have some components
func createEntity() -> GKEntity {
    
    // BEGIN componentbased_gameplaykit_entities
    // Create an entity, and attach some components
    let entity = GKEntity()
    
    entity.addComponent(GraphicsComponent())
    entity.addComponent(PhysicsComponent())
    // END componentbased_gameplaykit_entities
    
    return entity
}

let entities = [
    createEntity(),
    createEntity()
]

// BEGIN componentbased_gameplaykit_update_entities
// Update all components in each object
for entity in entities {
    entity.update(deltaTime: 0.033)
}
// END componentbased_gameplaykit_update_entities

// BEGIN componentbased_gameplaykit_componentsystem
let graphicsComponentSystem = GKComponentSystem(componentClass: GraphicsComponent.self)
let physicsComponentSystem = GKComponentSystem(componentClass: PhysicsComponent.self)
// END componentbased_gameplaykit_componentsystem

// BEGIN componentbased_gameplaykit_componentsystem_add
for entity in entities {
    graphicsComponentSystem.addComponent(foundIn: entity)
    physicsComponentSystem.addComponent(foundIn: entity)
}
// END componentbased_gameplaykit_componentsystem_add

// BEGIN componentbased_gameplaykit_componentsystem_update
// Update all of the graphics components
graphicsComponentSystem.update(deltaTime: 0.033)

// And then all of the physics components
physicsComponentSystem.update(deltaTime: 0.033)
// END componentbased_gameplaykit_componentsystem_update

//: [Next](@next)



