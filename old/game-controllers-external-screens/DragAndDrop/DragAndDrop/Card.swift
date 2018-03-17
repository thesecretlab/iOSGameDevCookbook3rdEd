//
//  Card.swift
//  DragAndDrop
//
//  Created by Jon Manning on 15/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

// BEGIN card
import UIKit

class Card: UIImageView {
    
    // The CardSlot that this card is in.
    var currentSlot : CardSlot?
    
    // Detects when the user drags this card.
    var dragGesture : UIPanGestureRecognizer?
    
    // Prepares the card to be add
    init(cardSlot: CardSlot) {
        currentSlot = cardSlot
        
        super.init(image: UIImage(named: "Card"))
        
        dragGesture = UIPanGestureRecognizer(target: self, action: "dragged:")
        
        self.center = cardSlot.center
        
        self.addGestureRecognizer(self.dragGesture!)
        self.userInteractionEnabled = true
    }
    
    // Called when the drag gesture recognizer changes state
    func dragged(dragGesture: UIPanGestureRecognizer) {
        switch dragGesture.state {
            
        // The user started dragging
        case .Began:
            
            // Work out where the touch currently is...
            var translation =
                dragGesture.translationInView(self.superview!)
            translation.x += self.center.x
            translation.y += self.center.y
            
            // Then animate to it.
            UIView.animateWithDuration(0.1) { () -> Void in
                self.center = translation
                
                // Also, rotate the card slightly.
                self.transform =
                    CGAffineTransformMakeRotation(CGFloat(M_PI) / 16.0)
            }
            
            // Reset the gesture recognizer in preparation
            // for the next time this method is called.
            
            dragGesture.setTranslation(CGPointZero, inView: self.superview)
            
            // If we aren't already at the front, bring ourselves
            // forward
            self.superview?.bringSubviewToFront(self)
        
        // The drag has changed position
        case .Changed:
            
            // Update our location to where the touch is now
            var translation = dragGesture.translationInView(self.superview!)
            translation.x += self.center.x
            translation.y += self.center.y
            
            self.center = translation
            
            dragGesture.setTranslation(CGPointZero, inView: self)
        
        // The drag ended
        case .Ended:
            
            
            // Find out if we were dragging over a location
            var destinationSlot : CardSlot?
            
            // For each view in the superview..
            for view in self.superview!.subviews {
                
                // If it's a CardSlot..
                if let cardSlot = view as? CardSlot {
                    
                    // And if the touch is inside that view
                    // AND that card slot doesn't have a card
                    if cardSlot.pointInside(
                        dragGesture.locationInView(cardSlot),
                        withEvent: nil) == true
                        && cardSlot.currentCard == nil {
                    
                            // ..Then this is our destination
                            destinationSlot = cardSlot
                            break;
                    }
                }
            }
            
            // If we have a new card slot, remove ourselves
            // from the old one and add to the new one
            if destinationSlot != nil {
                
                self.currentSlot?.currentCard = nil
                self.currentSlot = destinationSlot
                self.currentSlot?.currentCard = self
                
            }
            
            UIView.animateWithDuration(0.1) { () -> Void in
                self.center = self.currentSlot!.center
            }
        
        // The gesture was interrupted.
        case .Cancelled:
            
            UIView.animateWithDuration(0.1) { () -> Void in
                self.center = self.currentSlot!.center
            }
            
        default:
            () // do nothing
            
        }
        
        // If the drag has ended or was cancelled, remove the
        // rotation applied above
        if dragGesture.state == .Ended ||
            dragGesture.state == .Cancelled {
             UIView.animateWithDuration(0.1) { () -> Void in
                self.transform = CGAffineTransformIdentity;
             }
        }
        
    }
    
    // Fade out the view, and then remove it
    func delete() {
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.alpha = 0.0
            }) { (completed) -> Void in
                self.removeFromSuperview()
        }
        
    }
    
    // This initializer is required because we're a
    // subclass of UIImageView
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
// END card
