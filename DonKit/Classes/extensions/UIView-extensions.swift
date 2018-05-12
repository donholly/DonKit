//
//  UIView-extensions.swift
//  hims
//
//  Created by Don Holly on 4/29/18.
//  Copyright © 2018 Don Holly. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    public func xibSetup() {
        let view = loadFromNib()
        addSubview(view)
        setupContentView(view)
    }
    
    public func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }
        
        return view
    }

    private func setupContentView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
