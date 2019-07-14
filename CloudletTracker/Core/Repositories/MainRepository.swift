//
//  MainRepository.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Moya
import Result

protocol MainRepository {
    func fetchWeatherInfo(location: Location, completion: @escaping (Result<WeatherResponse, MoyaError>) -> Void)
    func fetchDailyForecast(
        location: Location,
        completion: @escaping(Result<DailyForecastResponse, MoyaError>) -> Void
    )
}

final class MainRepositoryImpl {
    private let weatherAPI: APIProvider<WeatherAPI>

    init(wheatherAPI: APIProvider<WeatherAPI>) {
        self.weatherAPI = wheatherAPI
    }
}

extension MainRepositoryImpl: MainRepository {
    func fetchWeatherInfo(location: Location, completion: @escaping (Result<WeatherResponse, MoyaError>) -> Void) {
        weatherAPI.request(.weather(location: location), completion: completion)
    }

    func fetchDailyForecast(
        location: Location,
        completion: @escaping(Result<DailyForecastResponse, MoyaError>) -> Void
        ) {
        weatherAPI.request(.dailyForecast(location: location), completion: completion)
    }
}
