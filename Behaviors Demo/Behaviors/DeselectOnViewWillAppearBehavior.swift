//
//  DeselectOnViewWillAppearBehavior.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class DeselectOnViewWillAppearBehavior: UIViewController, Behavior {
    private weak var tableView: UITableView?

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        (parent as? UITableViewController)?.clearsSelectionOnViewWillAppear = false
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let tableView = tableView,
            let selected = tableView.indexPathsForSelectedRows else { return }
        guard let transitionCoordinator = transitionCoordinator else {
            for indexPath in selected {
                tableView.deselectRow(at: indexPath, animated: false)
            }
            return
        }
        let deselect: (UIViewControllerTransitionCoordinatorContext) -> Void = { [weak tableView] _ in
            for indexPath in selected {
                tableView?.deselectRow(at: indexPath, animated: true)
            }
        }
        let reselectIfCancelled: (UIViewControllerTransitionCoordinatorContext) -> Void = { [weak tableView] context in
            guard context.isCancelled else { return }
            for indexPath in selected {
                tableView?.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
        transitionCoordinator.animate(alongsideTransition: deselect,
                                      completion: reselectIfCancelled)
    }
}
