//
//  CustomTapRegion.swift
//  TouchRegion
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class CustomTapRegion: UIView {

    // BEGIN point_inside
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        // A point is inside this view if it falls inside a rectangle that's 40pt
        // larger than the bounds of the view
        
        return CGRectContainsPoint(CGRectInset(self.bounds, -40, -40), point)
    }
    // END point_inside


}
