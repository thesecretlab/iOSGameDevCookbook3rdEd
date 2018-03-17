//: [Previous](@previous)

import Foundation
import GameplayKit

print("Random:")

// BEGIN randomisation_random
// Random distributions generate a random value every time
let dice = GKRandomDistribution(forDieWithSideCount: 6)

// Getting values from a random source
dice.nextBool()
dice.nextUniform()
dice.nextInt()
// END randomisation_random

(1...10).map {
    _ in
    
    print(dice.nextInt())
}

// Common dice sizes
// BEGIN randomisation_dice_sizes
let d6 = GKRandomDistribution.d6()
let d20 = GKRandomDistribution.d20()
// END randomisation_dice_sizes


print("Gaussian:")

// BEGIN randomisation_gaussian
// Gaussian distributions produce values that tend to be around the middle,
// and rarely produce values that tend to be at the edges
let gaussian = GKGaussianDistribution(forDieWithSideCount: 20)
// END randomisation_gaussian


(1...10).map {
    _ in
    
    print(gaussian.nextInt())
}

print("Shuffled")

// BEGIN randomisation_shuffled
// Shuffled distributions avoid repeating the same element
let shuffled = GKShuffledDistribution.d6()
// END randomisation_shuffled

(1...10).map {
    _ in
    
    print(shuffled.nextInt())
}

//: [Next](@next)
