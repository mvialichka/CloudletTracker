//
//  AppContract.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

protocol AppBuilder: AnyObject {
    func build() -> AppCoordinator
}

protocol AppPresenter: AnyObject {
    func viewDidLoad()
}

protocol AppView: AnyObject { }

protocol AppCoordinator: AnyObject {
    func start()
}
