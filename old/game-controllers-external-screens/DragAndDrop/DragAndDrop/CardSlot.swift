//
//  CardSlot.swift
//  DragAndDrop
//
//  Created by Jon Manning on 15/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN cardslot
@IBDesignable
class CardSlot: UIImageView {

    // @IBInspectable and @IBDesignable makes the deleteOnDrop
    // property appear in the interface builder
    @IBInspectable
    var deleteOnDrop : Bool = false

    var currentCard : Card? {
        // If we're given a new card, and this card slot is
        // 'delete on drop', delete that card instead of
        // making it be
        didSet {
            if self.deleteOnDrop == true {
                
                currentCard?.delete()
                self.currentCard = nil
                return
            }
        }
    }
    
    private var tap : UITapGestureRecognizer?
    
    override func awakeFromNib() {
        self.tap = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(self.tap!)
        
        self.userInteractionEnabled = true
    }
    
    func tapped(tap: UITapGestureRecognizer) {
        
        if tap.state == .Ended {
            // Only card slots that aren't "delete when cards
            // are dropped on them" can create cards
            if self.deleteOnDrop == false {
                let card = Card(cardSlot: self)
                
                self.superview?.addSubview(card)
                
                self.currentCard = card
            }
        }
        
    }

}
// END cardslot

