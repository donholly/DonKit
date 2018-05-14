//
//  Collection-extensions.swift
//  DonKit
//
//  Created by Don Holly on 5/12/18.
//

import Foundation

public extension NumberFormatter {
    private static let _internalQueue = DispatchQueue(label: "donkit.numberformatter.queue")
    private static var _numberFormatterCache = [String: NumberFormatter]()
    
    public class var usdFormatter: NumberFormatter {
        var formatter: NumberFormatter!
        _internalQueue.sync {
            if let f = _numberFormatterCache["usd"] {
                formatter = f
            } else {
                formatter = NumberFormatter()
                formatter.currencySymbol = "$"
                formatter.usesGroupingSeparator = true
                formatter.numberStyle = .currency
                _numberFormatterCache["usd"] = formatter
            }
        }
        return formatter
    }
}
