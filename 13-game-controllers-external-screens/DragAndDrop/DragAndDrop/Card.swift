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
        
        let draggedSelector = #selector(self.dragged(dragGesture:))
        
        dragGesture = UIPanGestureRecognizer(target: self,
                                             action: draggedSelector)
        
        self.center = cardSlot.center
        
        self.addGestureRecognizer(self.dragGesture!)
        self.isUserInteractionEnabled = true
    }
    
    // Called when the drag gesture recognizer changes state
    @objc func dragged(dragGesture: UIPanGestureRecognizer) {
        switch dragGesture.state {
            
        // The user started dragging
        case .began:
            
            // Work out where the touch currently is...
            var translation =
                dragGesture.translation(in: self.superview!)
            translation.x += self.center.x
            translation.y += self.center.y
            
            // Then animate to it.
            UIView.animate(withDuration: 0.1) { () -> Void in
                self.center = translation
                
                // Also, rotate the card slightly.
                self.transform =
                    CGAffineTransform(rotationAngle: .pi / 16.0)
            }
            
            // Reset the gesture recognizer in preparation
            // for the next time this method is called.
            
            dragGesture.setTranslation(CGPoint.zero, in: self.superview)
            
            // If we aren't already at the front, bring ourselves
            // forward
            self.superview?.bringSubview(toFront: self)
        
        // The drag has changed position
        case .changed:
            
            // Update our location to where the touch is now
            var translation = dragGesture.translation(in: self.superview!)
            translation.x += self.center.x
            translation.y += self.center.y
            
            self.center = translation
            
            dragGesture.setTranslation(CGPoint.zero,
                                       in: self)
        
        // The drag ended
        case .ended:
            
            
            // Find out if we were dragging over a location
            var destinationSlot : CardSlot?
            
            // For each view in the superview..
            for view in self.superview!.subviews {
                
                // If it's a CardSlot..
                if let cardSlot = view as? CardSlot {
                    
                    // And if the touch is inside that view
                    // AND that card slot doesn't have a card
                    if cardSlot.point(
                        inside: dragGesture.location(in: cardSlot),
                        with: nil) == true
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
            
            UIView.animate(withDuration: 0.1) { () -> Void in
                self.center = self.currentSlot!.center
            }
        
        // The gesture was interrupted.
        case .cancelled:
            
            UIView.animate(withDuration: 0.1) { () -> Void in
                self.center = self.currentSlot!.center
            }
            
        default:
            () // do nothing
            
        }
        
        // If the drag has ended or was cancelled, remove the
        // rotation applied above
        if dragGesture.state == .ended ||
            dragGesture.state == .cancelled {
            UIView.animate(withDuration: 0.1) { () -> Void in
                self.transform = CGAffineTransform.identity;
             }
        }
        
    }
    
    // Fade out the view, and then remove it
    func delete() {
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.alpha = 0.0
            }) { (completed) -> Void in
                self.removeFromSuperview()
        }
        
    }
    
    // This initializer is required because we're a
    // subclass of UIImageView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
// END card
