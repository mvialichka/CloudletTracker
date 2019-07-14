//
//  MainCoordinator.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

final class MainCoordinatorImpl {
    private let parent: UIViewController
    private let view: MainViewController

    init(parent: UIViewController, view: MainViewController) {
        self.parent = parent
        self.view = view
    }
}

extension MainCoordinatorImpl: MainCoordinator {
    func start() {
        parent.navigationController?.setViewControllers([view], animated: true)
    }

    func stop(completion: (() -> Void)?) {
        parent.navigationController?.popViewController(animated: true)
        completion?()
    }
}
