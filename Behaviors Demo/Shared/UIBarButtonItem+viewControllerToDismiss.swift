//
//  UIBarButtonItem+viewControllerToDismiss.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(viewControllerToDismiss: UIViewController) {
        self.init(barButtonSystemItem: .done,
                  target: viewControllerToDismiss,
                  action: #selector(UIViewController.dismissSelf))
    }
}

private extension UIViewController {
    @objc func dismissSelf() {
        dismiss(animated: true)
    }
}
