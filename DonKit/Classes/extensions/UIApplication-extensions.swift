//
//  UIApplication-extensions.swift
//  DonKit
//
//  Created by Don Holly on 12/20/17.
//

import Foundation

@objc public extension UIApplication {
    
    var threadSafeApplicationState: UIApplicationState {
        guard Thread.isMainThread else {
            return DispatchQueue.main.sync { applicationState }
        }
        return applicationState
    }
    
    var threadSafeBackgroundTimeRemaining: TimeInterval {
        guard Thread.isMainThread else {
            return DispatchQueue.main.sync { backgroundTimeRemaining }
        }
        return backgroundTimeRemaining
    }
    
    var topViewController: UIViewController? {
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
        
    }
}
