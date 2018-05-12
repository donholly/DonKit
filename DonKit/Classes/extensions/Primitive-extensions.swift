//
//  Int-extensions.swift
//  DonKit
//
//  Created by Don Holly on 1/18/18.
//

import Foundation

extension Int {
    static func random(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
    }
}

public extension Double {
    public static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }

    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}

extension Float {
    static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    
    static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}

public extension CGFloat {
    static var randomSign: CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
    
    public static var random: CGFloat {
        return CGFloat(Float.random)
    }

    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}
