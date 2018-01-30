//: [Previous](@previous)

import Foundation
import GameplayKit

// Random distributions generate a random value every time
let dice = GKRandomDistribution(forDieWithSideCount: 6)

// Getting values from a random source
dice.nextBool()
dice.nextUniform()
dice.nextInt()

(1...10).map {
    _ in dice.nextInt()
}

// Common dice sizes
let d6 = GKRandomDistribution.d6()
let d20 = GKRandomDistribution.d20()

// Gaussian distributions produce values that tend to be around the middle,
// and rarely produce values that tend to be at the edges
let gaussian = GKGaussianDistribution(forDieWithSideCount: 20)

(1...10).map {
    _ in gaussian.nextInt()
}

// Shuffled distributions avoid repeating the same element
let shuffled = GKShuffledDistribution.d6()

(1...10).map {
    _ in shuffled.nextInt()
}

//: [Next](@next)
