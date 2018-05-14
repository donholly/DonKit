//
//  UINavigationController-extensions.swift
//  DonKit
//
//  Created by Don Holly on 5/8/18.
//

import Foundation

extension UINavigationController {
    
    public func popToRootViewController(animated: Bool, completion: EmptyClosure?) {
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
        }
        
        self.popToRootViewController(animated: animated)
        
        if animated {
            CATransaction.commit()
        } else {
            completion?()
        }
    }
    
    public func popViewControllerWithHandler(animated: Bool, completion: EmptyClosure?) {
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
        }
        
        self.popViewController(animated: animated)
        
        if animated {
            CATransaction.commit()
        } else {
            completion?()
        }
    }
    
    public func pushViewController(viewController: UIViewController, animated: Bool, completion: EmptyClosure?) {
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
        }
        
        self.pushViewController(viewController, animated: animated)
        
        if animated {
            CATransaction.commit()
        } else {
            completion?()
        }
    }
    
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool, completion: EmptyClosure?) {
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
        }
        
        self.setViewControllers(viewControllers, animated: animated)
        
        if animated {
            CATransaction.commit()
        } else {
            completion?()
        }
    }
}
