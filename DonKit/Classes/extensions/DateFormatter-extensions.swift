//
//  Collection-extensions.swift
//  DonKit
//
//  Created by Don Holly on 5/12/18.
//

import Foundation

extension DateFormatter {
    
    private static let _internalQueue = DispatchQueue(label: "donkit.dateformatter.queue")
    private static var _dateFormatterCache = [String: DateFormatter]()
    
    public static func withFormat(_ format: String) -> DateFormatter {
        var formatter: DateFormatter!
        _internalQueue.sync {
            if let f = _dateFormatterCache[format] {
                formatter = f
            } else {
                formatter = DateFormatter()
                formatter.dateFormat = format
                _dateFormatterCache[format] = formatter
            }
        }
        return formatter
    }
    
    public static let iso8601WithMicroseconds: DateFormatter = {
        return withFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZZ")
    }()
}
