//
//  WrappingViewController.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class WrappingViewController: UIViewController & RevealOnScrollBehaviorDelegate {
    private let tableViewController = WrappedTableViewController()
    private let scrolledView = ContentHasScrolledView()
    private var hiddenConstraint: NSLayoutConstraint?
    private var visibleConstraint: NSLayoutConstraint?

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Wrapped Table Controller"
        navigationItem.leftBarButtonItem = UIBarButtonItem(viewControllerToDismiss: self)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableViewController.view)
        addChild(tableViewController)
        tableViewController.view.frame = view.bounds
        tableViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(scrolledView)
        scrolledView.translatesAutoresizingMaskIntoConstraints = false
        visibleConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrolledView.bottomAnchor)
        hiddenConstraint = scrolledView.topAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            scrolledView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: scrolledView.trailingAnchor),
            hiddenConstraint!
            ])
        inject(RevealOnScrollBehavior(scrollView: tableViewController.tableView, scrollPercent: 1, delegate: self))
    }

    func reachedTargetScrollPercent() {
        hiddenConstraint?.isActive = false
        visibleConstraint?.isActive = true
        UIView.animate(withDuration: 0.4) { [view] in
            view?.layoutIfNeeded()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newOffset = (view.frame.height - scrolledView.frame.minY) - view.safeAreaInsets.bottom
        if tableViewController.exteriorSafeAreaInsets.bottom != newOffset {
            tableViewController.exteriorSafeAreaInsets.bottom = newOffset
        }
    }
}
