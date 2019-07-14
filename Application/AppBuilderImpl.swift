//
//  AppBuilderImpl.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

final class AppBuilderImpl: AppBuilder {
    private let dependency: AppDependency

    init(dependency: AppDependency) {
        self.dependency = dependency
    }

    func build() -> AppCoordinator {
        let view = AppViewController()
        let navigation = UINavigationController()
        navigation.viewControllers = [view]
        let component = AppComponent(
            window: dependency.parent,
            parent: view,
            tokenHolder: dependency.tokenHolder
        )
        let mainBuilder = MainBuilderImpl(dependency: component)
        let router = AppRouter(mainBuilder: mainBuilder)
        let coordinator = AppCoordinatorImpl(window: dependency.parent, view: view)
        let presenter = AppPresenterImpl(
            view: view,
            router: router,
            jailbreakService: JailbreakServiceImpl()
        )
        view.presenter = presenter
        return coordinator
    }
}
