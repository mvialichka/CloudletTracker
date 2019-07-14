//
//  ActionButton.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/14/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    typealias Action = () -> Void

    var touchUpInside: Action? {
        didSet {
            if touchUpInside != nil {
                addTarget(self, action: #selector(ActionButton.touchUpInside(_:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(ActionButton.touchUpInside(_:)), for: .touchUpInside)
            }
        }
    }

    convenience init() {
        self.init(type: .system)
    }
}

private extension ActionButton {
    @objc func touchUpInside(_ sender: UIButton) {
        touchUpInside?()
    }
}
