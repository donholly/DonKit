//
//  Optional-extensions.swift
//  DonKit
//
//  Created by Don Holly on 5/27/17.
//

import Foundation

public extension Optional where Wrapped == String {
    
    var nilIfEmpty: String? {
        guard let value = self else {
            return nil
        }
        return value.isEmpty ? nil : value
    }

    var nullStringIfNil: String {
        guard let value = self else {
            return "(null)"
        }
        return value.isEmpty ? "(null)" : value
    }
}

public extension Optional {
    
    public var nullStringIfNil: Any {
        guard let value = self else {
            return "(null)"
        }
        return value
    }
}
