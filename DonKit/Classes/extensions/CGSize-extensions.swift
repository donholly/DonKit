//
//  Array-extensions.swift
//  DonKit
//
//  Created by Don Holly on 10/28/18.
//

import Foundation

public extension CGSize {

	public var aspectRatio: CGFloat {
		return self.width / self.height
	}
}
