//: Playground - noun: a place where people can play

import UIKit

// BEGIN linguistic_tagger
// Define the string we want to analyse
let input = "You'll need to destroy the Ring, Mr Frodo"

// Specify some options for how the linguistic tagger should operate
let options: NSLinguisticTagger.Options = [
    .omitWhitespace,
    .omitPunctuation,
    .joinNames
]

// Define what labels we're looking for in the input
let schemes = [
    NSLinguisticTagScheme.nameTypeOrLexicalClass,
    NSLinguisticTagScheme.lemma
]

// Create the tagger
let tagger = NSLinguisticTagger(tagSchemes: schemes,
                                options: Int(options.rawValue))
tagger.string = input

// Define a range that matches the entire input.
let range = NSRange(0..<input.count)

for scheme in schemes {
    print("Evaluating for scheme \(scheme.rawValue)")
    
    // For each word in the input, tag it with the current scheme and
    // run a closure.
    tagger.enumerateTags(in: range, scheme: scheme, options: options) {
        
        (tag, tokenRange, _, _) in
        
        // Get the part of the string that contains this word
        let token = (input as NSString).substring(with: tokenRange)
        
        // Print the information we found
        if let tag = tag {
            print("\(token): \(tag.rawValue)")
        } else {
            print("(no \(scheme.rawValue) tag for \"\(token)\")")
        }
    }
}
// END linguistic_tagger

/* Produces:
 
 // BEGIN linguistic_tagger_results
 Evaluating for scheme NameTypeOrLexicalClass
 You: Pronoun
 'll: Verb
 need: Verb
 to: Particle
 destroy: Verb
 the: Determiner
 Ring: Noun
 Mr Frodo: PersonalName
 
 Evaluating for scheme Lemma
 You: you
 'll: will
 need: need
 to: to
 destroy: destroy
 the: the
 Ring: ring
 (no Lemma tag for "Mr Frodo")
// END linguistic_tagger_results
 */

// BEGIN linguistic_tagger_tag_schemes
// Find all tag schemes for English
NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
// END linguistic_tagger_tag_schemes
