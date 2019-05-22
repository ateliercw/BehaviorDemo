//
//  ScrollViewDemoViewController.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 29/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class ScrollViewDemoViewController: UIViewController & AvoidKeyboardBehaviorDelegate {
    private let scrollView = UIScrollView()
    private let contentWrapper = UIView()
    private let titleLabel = UILabel()
    private let textEntry = UITextField()

    var keyboardSafeAreaInsets = UIEdgeInsets() {
        didSet {
            scrollView.contentInset.bottom = keyboardSafeAreaInsets.bottom
            if keyboardSafeAreaInsets.bottom == scrollView.safeAreaInsets.bottom {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Scroll view"
        navigationItem.leftBarButtonItem = UIBarButtonItem(viewControllerToDismiss: self)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = scrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .white
        titleLabel.text = "Title"

        textEntry.placeholder = "Text entry"

        contentWrapper.preservesSuperviewLayoutMargins = true
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.keyboardDismissMode = .onDrag

        contentWrapper.addSubview(titleLabel)
        contentWrapper.addSubview(textEntry)
        scrollView.addSubview(contentWrapper)

        for view in [titleLabel, textEntry, contentWrapper] {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        var constraints = [NSLayoutConstraint]()

        constraints += [
            contentWrapper.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor),
            contentWrapper.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]

        constraints += [
            titleLabel.firstBaselineAnchor
                .constraint(equalToSystemSpacingBelow: contentWrapper.safeAreaLayoutGuide.topAnchor,
                            multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalTo: contentWrapper.readableContentGuide.leadingAnchor),
            contentWrapper.readableContentGuide.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]

        constraints += [
            textEntry.firstBaselineAnchor
                .constraint(greaterThanOrEqualToSystemSpacingBelow: titleLabel.lastBaselineAnchor,
                            multiplier: 1),
            textEntry.leadingAnchor.constraint(equalTo: contentWrapper.layoutMarginsGuide.leadingAnchor),
            contentWrapper.layoutMarginsGuide.trailingAnchor.constraint(equalTo: textEntry.trailingAnchor),
            contentWrapper.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: textEntry.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        inject(EndEditingOnDisappearBehavior())
        inject(AvoidKeyboardBehavior(scrollView: scrollView, delegate: self))
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        textEntry.font = UIFont.preferredFont(forTextStyle: .body)
    }
}
