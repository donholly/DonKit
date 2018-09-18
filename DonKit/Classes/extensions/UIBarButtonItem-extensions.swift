//
//  UIBarButtonItem-extensions.swift
//  DonKit
//
//  Created by Don Holly on 2/27/18.
//

import Foundation

public typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> ()

public class UIBarButtonItemClosureWrapper: NSObject {
    let closure: UIBarButtonItemTargetClosure
    init(_ closure: @escaping UIBarButtonItemTargetClosure) {
        self.closure = closure
    }
}

public extension UIBarButtonItem {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    public var actionClosure: UIBarButtonItemTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIBarButtonItemClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIBarButtonItemClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public convenience init(title: String?, style: UIBarButtonItem.Style, closure: @escaping UIBarButtonItemTargetClosure) {
        self.init(title: title, style: style, target: nil, action: nil)
        actionClosure = closure
        target = self
        action = #selector(closureAction)
    }
    
    public convenience init(image: UIImage, closure: @escaping UIBarButtonItemTargetClosure) {
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.init(customView: button)
        
        actionClosure = closure
        button.addTarget(self, action: #selector(closureAction), for: .touchUpInside)
    }
    
    @objc public func closureAction() {
        actionClosure?(self)
    }
}
