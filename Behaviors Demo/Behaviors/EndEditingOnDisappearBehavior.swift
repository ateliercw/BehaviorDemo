//
//  EndEditingOnDisappearBehavior.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 22/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

class EndEditingOnDisappearBehavior: UIViewController & Behavior {
    override func viewWillDisappear(_ animated: Bool) {
        parent?.view.endEditing(true)
    }
}
