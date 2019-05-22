//
//  SimpleTableViewCell.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.textColor = .gray
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
