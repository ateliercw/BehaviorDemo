//
//  MainContentTableViewController.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit
import Reusable

class MainContentTableViewController: UITableViewController {
    init() {
        super.init(style: .plain)
        title = "Behaviors"
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(cellType: SimpleTableViewCell.self)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let rows = MainContentTableViewController.Row.allCases
}

// MARK: - UITableViewDataSource
extension MainContentTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell: SimpleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.detail
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainContentTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        let toPresent = UINavigationController(rootViewController: row.viewController())
        present(toPresent, animated: true)
    }
}

// MARK: - Rows
extension MainContentTableViewController {
    enum Row: CaseIterable {
        case base
        case wrapping
        case scrollView

        var title: String {
            let title: String
            switch self {
            case .base: title = "Base"
            case .wrapping: title = "Wrapping"
            case .scrollView: title = "Scroll view"
            }
            return title
        }

        var detail: String {
            let detail: String
            switch self {
            case .base: detail = "Subclassing UIViewController"
            case .wrapping: detail = "UIViewController wrapping UITableViewController"
            case .scrollView: detail = "Scroll view with keyboard avoidance"
            }
            return detail
        }

        func viewController() -> UIViewController {
            let viewController: UIViewController
            switch self {
            case .base: viewController = BaseViewController()
            case .wrapping: viewController = WrappingViewController()
            case .scrollView: viewController = ScrollViewDemoViewController()
            }
            return viewController
        }
    }
}
