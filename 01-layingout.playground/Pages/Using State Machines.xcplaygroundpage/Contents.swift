//: [Previous](@previous)

import Foundation

import GameplayKit

// BEGIN statemachine_states
// The 'Building Up an Army' state
class BuildUpState : GKState {
    
    override func didEnter(from previousState: GKState?) {
        print("Now building up!")
    }
    
    // Called every time the state machine is updated
    override func update(deltaTime seconds: TimeInterval) {
        print("Building in progress!")
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

// The 'Attacking with the Army' state
class AttackState : GKState {
    
    override func didEnter(from previousState: GKState?) {
        // Called when we enter this state
        print("Now attacking the enemy!")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        // Called every time the state machine is updated
        print("Attack in progress!")
    }
}

// The 'Withdrawing the Army from Attack' state
class WithdrawState : GKState {
    
}

// The 'Defeated' state
class DefeatedState : GKState {
    override func didEnter(from previousState: GKState?) {
        // Called when we enter this state
        print("I'm defeated!")
        
        // Use 'previousState' to learn about the state we entered from
        if previousState is BuildUpState {
            print("I was in the middle of building up, too!")
        }
    }
}
// END statemachine_states

// BEGIN statemachine_setup
// Create instances of the states
let states = [
    BuildUpState(),
    AttackState(),
    WithdrawState(),
    DefeatedState()
]

let stateMachine = GKStateMachine(states: states)
// END statemachine_setup

// BEGIN statemachine_enterstates
stateMachine.enter(BuildUpState.self)
stateMachine.enter(AttackState.self)
stateMachine.enter(BuildUpState.self)
stateMachine.enter(DefeatedState.self)
// END statemachine_enterstates

// BEGIN statemachine_current_state
stateMachine.currentState
// END statemachine_current_state

// BEGIN statemachine_update
stateMachine.update(deltaTime: 0.033)
// END statemachine_update

// BEGIN statemachine_get_state
let state = stateMachine.state(forClass: BuildUpState.self)
// END statemachine_get_state


// BEGIN statemachine_can_enter_state
stateMachine.enter(BuildUpState.self)
stateMachine.canEnterState(WithdrawState.self)
// = false
// END statemachine_can_enter_state
//: [Next](@next)
