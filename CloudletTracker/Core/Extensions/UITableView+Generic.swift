//
//  UITableView+Generic.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReuseIdentifiable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReuseIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier) at indexPath: \(indexPath)")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReuseIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReuseIdentifiable {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)

    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReuseIdentifiable {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue header footer with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
