//
//  WrappedTableViewController.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class WrappedTableViewController: UITableViewController & AvoidKeyboardBehaviorDelegate {
    var keyboardSafeAreaInsets: UIEdgeInsets = UIEdgeInsets() {
        didSet {
            updateInsets()
        }
    }

    var exteriorSafeAreaInsets: UIEdgeInsets = UIEdgeInsets() {
        didSet {
            updateInsets()
        }
    }
    private func updateInsets() {
        additionalSafeAreaInsets = UIEdgeInsets(top: max(keyboardSafeAreaInsets.top,
                                                         exteriorSafeAreaInsets.top),
                                                left: max(keyboardSafeAreaInsets.left,
                                                          exteriorSafeAreaInsets.left),
                                                bottom: max(keyboardSafeAreaInsets.bottom,
                                                            exteriorSafeAreaInsets.bottom),
                                                right: max(keyboardSafeAreaInsets.right,
                                                           exteriorSafeAreaInsets.right))
    }

    init() {
        super.init(style: .plain)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DemoRow.registerCells(for: tableView)
        tableView.keyboardDismissMode = .onDrag
        inject(EndEditingOnDisappearBehavior())
        inject(DeselectOnViewWillAppearBehavior(tableView: tableView))
        inject(AvoidKeyboardBehavior(scrollView: tableView, delegate: self))
    }

    private let rows = DemoRow.allCases
}

// MARK: - UITableViewDataSource
extension WrappedTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row].cell(for: tableView, at: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension WrappedTableViewController {
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return rows[indexPath.row].shouldHighlight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PushedViewController(), animated: true)
    }
}
