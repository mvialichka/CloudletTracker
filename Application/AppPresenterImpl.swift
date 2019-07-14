//
//  AppPresenterImpl.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

final class AppPresenterImpl {
    private unowned let view: AppView
    private let router: AppRouter
    private let jailbreakService: JailbreakService

    init(view: AppView, router: AppRouter, jailbreakService: JailbreakService) {
        self.view = view
        self.router = router
        self.jailbreakService = jailbreakService
    }
}

extension AppPresenterImpl: AppPresenter {
    func viewDidLoad() {
        if !jailbreakService.isJailbroken {
            router.openLogin()
        } else {
            fatalError("You shall not pass!")
        }
    }
}
