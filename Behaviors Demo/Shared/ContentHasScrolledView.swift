//
//  ContentHasScrolledView.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 23/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class ContentHasScrolledView: UIView {
    private let label = UILabel()

    init() {
        super.init(frame: CGRect())
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        backgroundColor = .white
        label.textAlignment = .center
        label.text = "All done"
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor)
            ])
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        label.font = .preferredFont(forTextStyle: .body)
    }
}
