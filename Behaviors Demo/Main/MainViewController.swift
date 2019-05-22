//
//  MainViewController.swift
//  Behaviors
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationBar.prefersLargeTitles = true
        setViewControllers([MainContentTableViewController()], animated: false)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
