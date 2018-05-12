//
//  Bundle-extensions.swift
//  DonKit
//
//  Created by Don Holly on 2/5/18.
//

import Foundation

extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildNumber: String? {
        return infoDictionary?[kCFBundleVersionKey as String] as? String
    }
}
