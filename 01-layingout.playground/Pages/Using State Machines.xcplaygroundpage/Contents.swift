//: [Previous](@previous)

import Foundation

import GameplayKit

// BEGIN statemachine_states
class BuildUpState : GKState {
    
    override func didEnter(from previousState: GKState?) {
        print("Now building up!")
    }
    
    // Called every time the state machine is updated
    override func update(deltaTime seconds: TimeInterval) {
        print("Building up the army!")
    }
    
    // Called when we leave this state
    override func willExit(to nextState: GKState) {
        print("Stopping buildup!")
    }
    
    // BEGIN statemachine_limit_states
    // Limiting which states we can proceed to from here
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        if stateClass == AttackState.self || stateClass == DefeatedState.self {
            return true
        } else {
            return false
        }
    }
    // END statemachine_limit_states
    
}

// Some additional states:
class AttackState : GKState {
    
    override func didEnter(from previousState: GKState?) {
        // Called when we enter this state
        print("Now attacking the enemy!")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        // Called every time the state machine is updated
        print("Attacking the enemy!")
    }
}

class WithdrawState : GKState {
    
}

class DefeatedState : GKState {
    override func didEnter(from previousState: GKState?) {
        // Called when we enter this state
        print("I'm defeated!")
    }
}
// END statemachine_states

// BEGIN statemachine_setup
// Create instances of the states
let states = [
    BuildUpState(),
    AttackState(),
    WithdrawState()
]

let stateMachine = GKStateMachine(states: states)
// END statemachine_setup

// BEGIN statemachine_enterstates
stateMachine.enter(BuildUpState.self)
stateMachine.enter(AttackState.self)
stateMachine.enter(BuildUpState.self)
// END statemachine_enterstates

// BEGIN statemachine_update
stateMachine.update(deltaTime: 0.033)
// END statemachine_update

// BEGIN statemachine_get_state
let state = stateMachine.state(forClass: BuildUpState.self)
// END statemachine_get_state

//: [Next](@next)
