//
//  BaseViewController.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController & AvoidKeyboardBehaviorDelegate & RevealOnScrollBehaviorDelegate {
    private let scrolledView = ContentHasScrolledView()
    private var hiddenConstraint: NSLayoutConstraint?
    private var visibleConstraint: NSLayoutConstraint?

    var keyboardSafeAreaInsets = UIEdgeInsets() {
        didSet {
            tableView.contentInset.bottom = keyboardSafeAreaInsets.bottom
        }
    }

    let tableView = UITableView(frame: CGRect(), style: .plain)

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Base view controller"
        navigationItem.leftBarButtonItem = UIBarButtonItem(viewControllerToDismiss: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DemoRow.registerCells(for: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        view.addSubview(tableView)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.frame = view.frame
        view.addSubview(scrolledView)
        scrolledView.translatesAutoresizingMaskIntoConstraints = false
        visibleConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrolledView.bottomAnchor)
        hiddenConstraint = scrolledView.topAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            scrolledView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: scrolledView.trailingAnchor),
            hiddenConstraint!
            ])
        inject(EndEditingOnDisappearBehavior())
        inject(DeselectOnViewWillAppearBehavior(tableView: tableView))
        inject(AvoidKeyboardBehavior(scrollView: tableView, delegate: self))
        inject(RevealOnScrollBehavior(scrollView: tableView, scrollPercent: 1, delegate: self))
    }

    private let rows = DemoRow.allCases

    func reachedTargetScrollPercent() {
        hiddenConstraint?.isActive = false
        visibleConstraint?.isActive = true
        UIView.animate(withDuration: 0.4) { [view] in
            view?.layoutIfNeeded()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newInset = (view.frame.height - scrolledView.frame.minY) - view.safeAreaInsets.bottom
        if tableView.contentInset.bottom != newInset {
            tableView.contentInset.bottom = newInset
        }
    }
}

extension BaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row].cell(for: tableView, at: indexPath)
    }
}

extension BaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return rows[indexPath.row].shouldHighlight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PushedViewController(), animated: true)
    }
}
