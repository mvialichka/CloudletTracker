//
//  AppRouter.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Foundation

final class AppRouter {
    private let mainBuilder: MainBuilder
    private var mainCoordinator: MainCoordinator?

    init(mainBuilder: MainBuilder) {
        self.mainBuilder = mainBuilder
    }

    func openLogin() {
        mainCoordinator = mainBuilder.build(listener: self)
        mainCoordinator?.start()
    }
}

extension AppRouter: MainListener { }
