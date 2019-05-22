//
//  DemoRow.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit
import Reusable

extension TextEntryTableViewCell: Reusable {}
extension SimpleTableViewCell: Reusable {}

enum DemoRow: CaseIterable {
    case push(Int)
    case textInput

    static var allCases: [DemoRow] {
        let pushRows = (1...8).map(DemoRow.push)
        let morePushRows = (9...16).map(DemoRow.push)
        let yetMorePushRows = (9...16).map(DemoRow.push)
        let finalPushRows = (9...16).map(DemoRow.push)
        return pushRows +
            [.textInput] +
            morePushRows +
            [.textInput] +
            yetMorePushRows +
            [.textInput] +
            finalPushRows
    }

    private var title: String {
        switch self {
        case .push(let index): return "Push \(index)"
        case .textInput: return "Text input"
        }
    }

    var shouldHighlight: Bool {
        switch self {
        case .push: return true
        case .textInput: return false
        }
    }

    static func registerCells(for tableView: UITableView) {
        tableView.register(cellType: SimpleTableViewCell.self)
        tableView.register(cellType: TextEntryTableViewCell.self)
    }

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch self {
        case .push:
            cell = tableView.dequeueReusableCell(for: indexPath) as SimpleTableViewCell
            cell.textLabel?.text = title
        case .textInput:
            let textInputCell = tableView.dequeueReusableCell(for: indexPath) as TextEntryTableViewCell
            textInputCell.titleLabel.text = title
            cell = textInputCell
        }
        return cell
    }
}
