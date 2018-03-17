//: [Previous](@previous)
/*
import Foundation
import GameplayKit

class Game {
    var players : [GKEntity] = []
    
    func addPlayer(skill: Float, aggressiveness: Float,
                   eagerness: Int) -> GKEntity {
        let entity = GKEntity()
        
        let playerName = "Player \(self.players.count+1)"
        let data = PlayerDataComponent(
            name: playerName,
            skill: skill,
            aggressiveness: aggressiveness,
            eagerness: eagerness
        )
        
        players.append(entity)
        
        return entity
    }
    
    func update(deltaTime seconds: TimeInterval) {
        for player in players {
            player.update(deltaTime: seconds)
        }
    }
    
    var gameComplete: Bool {
        get {
            
            let playerCurrentStates = self.players.map {
                $0.data.statemachine.currentState
            }
            
            // The game is over when there is one (or fewer) players undefeated
            return playerCurrentStates
                .filter({ type(of: $0) != DefeatedState.self})
                .count <= 1
        }
    }
    
}

extension GKEntity {
    // A convenience property to make it easier to access the
    // EnemyDataComponent on this entity
    var data : PlayerDataComponent {
        guard let component =
            self.component(ofType: PlayerDataComponent.self) else {
                fatalError("No data component here; did you forget to add it?")
        }
        
        return component
    }
    
}

class PlayerDataComponent: GKComponent {
    
    // The player's display name
    let name : String
    
    // The number of units in our base
    // Float because the fractional part represents the health -
    // 1.5 means we have two units, but one is at 50% health
    var armyAtHome : Float {
        didSet {
            // If this ever reaches zero, we are defeated
            if armyAtHome <= 0 {
                armyAtHome = 0
                self.statemachine.enter(DefeatedState.self)
            }
        }
    }
    
    // The number of units in another player's base
    var armyAttacking : Float
    
    // How quickly productionProgress increases over time
    let skill : Float
    
    // We'll attack when armyAtHome is at this value
    let eagerness : Int
    
    // 0-1; what percentage of armyAtHome is sent to armyAttacking
    let aggressiveness : Float
    
    // The state machine that controls which state this component is in
    let statemachine: GKStateMachine
    
    init(name: String, skill: Float, aggressiveness: Float, eagerness: Int) {
        
        self.name = name
        self.skill = skill
        self.aggressiveness = aggressiveness
        self.eagerness = eagerness
        
        self.armyAtHome = 0
        self.armyAttacking = 0
        
        // Prepare the states we can enter
        let states = [
            BuildUpState(data: self),
            AttackState(data: self),
            WithdrawState(data: self)
        ]
        
        // Create the state machine with these states
        self.statemachine = GKStateMachine(states: states)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var enemy : GKEntity {
        get {
            guard let attackState =
                self.statemachine.state(forClass: AttackState.self) else {
                    fatalError("Can't set enemy: no attack state present")
            }
            
            return attackState.enemy!
        }
        set {
            guard let attackState =
                self.statemachine.state(forClass: AttackState.self) else {
                    fatalError("Can't set enemy: no attack state present")
            }
            
            attackState.enemy = newValue
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        self.statemachine.update(deltaTime: seconds)
    }
    
    override var description: String {
        return "\(self.name): State: \(self.statemachine.currentState); " +
            "\(self.armyAttacking) attacking, \(self.armyAttacking) at home"
    }
}

class EnemyState : GKState {
    
    let data: PlayerDataComponent
    
    init(data: PlayerDataComponent) {
        self.data = data
    }
    
    override func didEnter(from previousState: GKState?) {
        print("\(self.data.name): \(previousState.description ?? "no state") -> \(self.description)")
    }
    
}

class BuildUpState : EnemyState {
    override func update(deltaTime seconds: TimeInterval) {
        
        // Production increases at a rate of skill per second
        self.data.armyAtHome += self.data.skill * seconds
        
        // Transition to Attacking when appropriate
        if self.data.armyAtHome >= self.data.eagerness {
            self.stateMachine?.enter(AttackState.self)
        }
        
    }
}

class AttackState : EnemyState {
    var enemy : GKEntity?
    
    override func didEnter(from previousState: GKState?) {
        
        super.didEnter(from: previousState)
        
        // Transfer units from armyAtHome into armyAttacking
        
        var numberToTransfer = self.data.aggressiveness * self.data.armyAtHome
        
        // Don't transfer more than we have
        var numberToTransfer = Float.minimum(self.data.armyAtHome, numberToTransfer)
        
        self.data.armyAtHome -= numberToTransfer
        self.data.armyAttacking += numberToTransfer
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        // If we don't have an enemy, fail
        guard let enemy = self.enemy else {
            fatalError("\(self.data.name) is Attacking, but no enemy was set")
        }
        
        // Calculate how well the battle's going
        var myPower = self.data.armyAttacking * self.data.skill
        var theirPower = enemy.data.armyAtHome * enemy.data.skill
        
        // We lose attackers at a rate of theirPower per second
        self.data.armyAttacking -= theirPower * seconds
        
        // They lose defenders at a rate of myPower per second
        enemy.data.armyAtHome -= myPower * seconds
        
        // If we have less than 10% attacking than defending, or if we are
        // victorious, withdraw our army
        
        if (self.data.armyAttacking / self.data.armyAtHome) < 0.1 ||
            enemy.data.armyAtHome <= 0 {
            self.stateMachine?.enter(WithdrawState.self)
        }
        
    }
}

class WithdrawState : EnemyState {
    override func update(deltaTime seconds: TimeInterval) {
        
        // Remove army at a rate of skill per second
        var transferAmount = self.data.skill * seconds
        
        // Don't transfer more than exist
        transferAmount = Float.minimum(self.data.armyAttacking, transferAmount)
        
        // Transfer the units
        self.data.armyAtHome += transferAmount
        self.data.armyAttacking -= transferAmount
        
        // If we have no more army attacking, we are now building up
        if self.data.armyAttacking <= 0 {
            self.stateMachine?.enter(BuildUpState.self)
        }
    }
}

class DefeatedState : EnemyState {
}

let game = Game()

let player1 = game.addPlayer(skill: 2.0, aggressiveness: 0.5, eagerness: 20)
let player2 = game.addPlayer(skill: 1.5, aggressiveness: 0.8, eagerness: 40)

player1.data.enemy = player2
player2.data.enemy = player1

while game.gameComplete == false {
    game.update(deltaTime: 0.33)
}

//: [Next](@next)
*/
