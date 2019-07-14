//
//  ReuseIdentifiable.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
