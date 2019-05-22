//
//  Behavior.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

protocol Behavior {}

extension UIViewController {
    func inject(_ behavior: UIViewController & Behavior) {
        view.addSubview(behavior.view)
        behavior.view.isHidden = true
        addChild(behavior)
    }
}
