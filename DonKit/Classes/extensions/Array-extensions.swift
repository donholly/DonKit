//
//  Array-extensions.swift
//  DonKit
//
//  Created by Don Holly on 12/5/17.
//

import Foundation

public extension Array {
    public func split(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
    
    /// Shuffle the elements of `self` in-place.
    public mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            self.swapAt(i, j)
        }
    }
}
