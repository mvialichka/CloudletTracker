//
//  AppCoordinator.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

final class AppCoordinatorImpl {
    private let view: AppViewController
    private let window: UIWindow

    init(window: UIWindow, view: AppViewController) {
        self.window = window
        self.view = view
    }
}

extension AppCoordinatorImpl: AppCoordinator {
    func start() {
        window.rootViewController = view.navigationController
        window.makeKeyAndVisible()
    }
}
