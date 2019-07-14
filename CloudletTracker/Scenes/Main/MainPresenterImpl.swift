//
//  MainPresenterImpl.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Foundation

final class MainPresenterImpl: MainPresenter {
    private unowned let view: MainView
    private let router: MainRouter
    private let dateFormatterUseCase: DateFormatterUseCase
    private let dayForecastMapper: DayForecastMapper
    private let mainInteractor: MainInteractor

    init(view: MainView, router: MainRouter, dateFormatterUseCase: DateFormatterUseCase, dayForecastMapper: DayForecastMapper, mainInteractor: MainInteractor) {
        self.view = view
        self.router = router
        self.dateFormatterUseCase = dateFormatterUseCase
        self.dayForecastMapper = dayForecastMapper
        self.mainInteractor = mainInteractor
    }

    func viewDidLoad() {
        view.display(temperatureStaticTitle: "Temperature:")
        view.display(pressureStaticTitle: "Pressure:")
        view.display(windStaticTitle: "Wind speed:")
        view.display(sunriseStaticTitle: "Sunrise time:")
        view.display(sunsetStaticTitle: "Sunset time:")
        updateWeatherInfo()
    }

    func handleUpdateButtonPress() {
        updateWeatherInfo()
    }
}

private extension MainPresenterImpl {
    func updateWeatherInfo() {
        mainInteractor.fetchWeatherInfo { [weak self] (result) in
            switch result {
            case .success(let wheatherInfo):
                self?.view.display(temperature: "\(wheatherInfo.weatherMainInfo.temperature) \u{00B0}F")
                self?.view.display(pressure: "\(Int(wheatherInfo.weatherMainInfo.pressure)) mm")
                self?.view.display(windSpeed: "\(wheatherInfo.windInfo.speed) m/s")
                if let sunriseTime = self?.dateFormatterUseCase.format(milliseconds:wheatherInfo.sunriseInfo.sunrise) {
                    self?.view.display(sunriseTime: "\(sunriseTime)")
                } else {
                    self?.view.display(sunriseTime: "N/A")
                }
                if let sunsetTime = self?.dateFormatterUseCase.format(milliseconds:wheatherInfo.sunriseInfo.sunset) {
                    self?.view.display(sunsetTime: "\(sunsetTime)")
                } else {
                    self?.view.display(sunsetTime: "N/A")
                }
            case .failure:
                fatalError("Can't parse weather info")
            }
        }
        mainInteractor.fetchDailyForecast { [weak self] (result) in
            switch result {
            case .success(let dailyForecast):
                self?.view.display(threeDaysForecastItems: dailyForecast.forecastsList.compactMap { self?.dayForecastMapper.mapDayForecastToItem($0) })
            case .failure:
                fatalError("Can't parse daily forecast")
            }
        }
    }
}
