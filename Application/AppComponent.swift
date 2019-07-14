//
//  AppComponent.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

final class AppComponent: MainDependency {
    let window: UIWindow
    let parent: UIViewController
    let tokenHolder: TokenHolder

    init(window: UIWindow, parent: UIViewController, tokenHolder: TokenHolder) {
        self.window = window
        self.parent = parent
        self.tokenHolder = tokenHolder
    }
}
