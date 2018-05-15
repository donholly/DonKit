//
//  Array-extensions.swift
//  DonKit
//
//  Created by Don Holly on 5/14/18.
//

public extension Encodable {
	public var dictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
}
