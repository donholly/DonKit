//
//  Constants.swift
//  DonKit
//
//  Created by Don Holly on 11/1/17.
//

public typealias BoolCompletionClosure = ((_: Bool) -> Void)
public typealias EmptyClosure = () -> Void
public typealias ErrorableCompletionClosure = ((_ error: Error?) -> Void)
public typealias ErrorableBoolCompletionClosure = ((_ success: Bool, _ error: Error?) -> Void)
public typealias ErrorableStringCompletionClosure = ((_ string: String?, _ error: Error?) -> Void)
