//
//  MainRouterImpl.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

final class MainRouterImpl {
    private weak var listener: MainListener?

    init(listener: MainListener) {
        self.listener = listener
    }
}

extension MainRouterImpl: MainRouter { }
