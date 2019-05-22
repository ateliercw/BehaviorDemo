//
//  TextEntryTableViewCell.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class TextEntryTableViewCell: UITableViewCell {
    private let textEntry = UITextField()
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        textEntry.placeholder = "Enter some text"
        contentView.addSubview(titleLabel)
        contentView.addSubview(textEntry)
        textEntry.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor),
            titleLabel.firstBaselineAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: contentView.topAnchor,
                                                      multiplier: 1),
            textEntry.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: titleLabel.lastBaselineAnchor,
                                                     multiplier: 1),
            textEntry.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textEntry.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: textEntry.lastBaselineAnchor,
                                                multiplier: 1)
            ])
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        textEntry.text = nil
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        textEntry.font = .preferredFont(forTextStyle: .body)
        titleLabel.font = .preferredFont(forTextStyle: .caption1)
    }
}
