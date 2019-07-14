//
//  AppDelegate.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let tokenHolder = TokenHolder()
        let dependency = AppDependency(
            parent: window,
            tokenHolder: tokenHolder
        )

        let appBuilder = AppBuilderImpl(dependency: dependency)
        let appCoordinator = appBuilder.build()
        appCoordinator.start()
        
        return true
    }
}
