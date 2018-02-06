//: Playground - noun: a place where people can play

import UIKit

let question = "You'll need to destroy the Ring, Mr Frodo"
let options: NSLinguisticTagger.Options = [
    .omitWhitespace,
    .omitPunctuation,
    .joinNames
]

//let schemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")

let schemes = [NSLinguisticTagScheme.nameTypeOrLexicalClass]

let tagger = NSLinguisticTagger(tagSchemes: schemes, options: Int(options.rawValue))
tagger.string = question

// Define a range that matches the entire input.
let range = NSRange(0..<question.count)

for scheme in schemes {
    print("Evaluating for scheme \(scheme.rawValue)")
    
    tagger.enumerateTags(in: range, scheme: scheme, options: options) { (tag, tokenRange, _, _) in
        
        let token = (question as NSString).substring(with: tokenRange)
        
        if let tag = tag {
            print("\(token): \(tag.rawValue)")
        } else {
            print("(no \(scheme.rawValue) tag for \"\(token)\")")
        }
        
    }
    print()
}

/* Produces:
 
 Evaluating for scheme NameTypeOrLexicalClass
 You: Pronoun
 'll: Verb
 need: Verb
 to: Particle
 destroy: Verb
 the: Determiner
 Ring: Noun
 Mr Frodo: PersonalName
 
 */
