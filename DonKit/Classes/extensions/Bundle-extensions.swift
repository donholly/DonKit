//
//  Bundle-extensions.swift
//  DonKit
//
//  Created by Don Holly on 2/5/18.
//

import Foundation

public extension Bundle {
    public var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildNumber: String? {
        return infoDictionary?[kCFBundleVersionKey as String] as? String
    }
}
