//
//  CGPoint-extensions.swift
//  DonKit
//
//  Created by Don Holly on 1/17/18.
//

extension CGPoint {

func distanceFrom(_ b: CGPoint) -> CGFloat {
    let xDist = self.x - b.x
    let yDist = self.y - b.y
    return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
}

}
