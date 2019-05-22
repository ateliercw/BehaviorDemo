//
//  PushedViewController.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class PushedViewController: UIViewController {
    private let label = UILabel()

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Pushed"
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        label.text = "Nothing to see here."
        label.numberOfLines = 0
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.readableContentGuide.leadingAnchor,
                                           multiplier: 1),
            label.centerXAnchor.constraint(equalTo: view.readableContentGuide.centerXAnchor),
            label.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
                                       multiplier: 1),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        label.font = UIFont.preferredFont(forTextStyle: .body)
    }
}
