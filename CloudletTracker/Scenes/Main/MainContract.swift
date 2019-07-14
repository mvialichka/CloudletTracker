//
//  MainContract.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit
import Result
import Moya

protocol MainDependency: AnyObject {
    var parent: UIViewController { get }
    var tokenHolder: TokenHolder { get }
}

protocol MainListener: AnyObject { }

protocol MainCoordinator: AnyObject {
    func start()
    func stop(completion: (() -> Void)?)
}

protocol MainBuilder: AnyObject {
    func build(listener: MainListener) -> MainCoordinator
}

protocol MainRouter: AnyObject { }

protocol MainView: AnyObject {
    func display(temperatureStaticTitle: String)
    func display(temperature: String)
    func display(pressureStaticTitle: String)
    func display(pressure: String)
    func display(windStaticTitle: String)
    func display(windSpeed: String)
    func display(sunriseStaticTitle: String)
    func display(sunriseTime: String)
    func display(sunsetStaticTitle: String)
    func display(sunsetTime: String)
    func display(threeDaysForecastItems: [ForecastTableViewItem])
}

protocol MainPresenter: AnyObject {
    func viewDidLoad()
    func handleUpdateButtonPress()
}

protocol MainInteractor: AnyObject {
    func fetchWeatherInfo(completion: @escaping (Result<WeatherInfo, MoyaError>) -> Void)
    func fetchDailyForecast(completion: @escaping (Result<DailyForecast, MoyaError>) -> Void)
}
