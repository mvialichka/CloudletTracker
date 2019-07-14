//
//  MainInteractor.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Moya
import Result

final class MainInteractorImpl {
    private let mainRepository: MainRepository
    private let locationUseCase: GeolocationUseCase
    private let localStorage: LocalStorage

    init(mainRepository: MainRepository, locationUseCase: GeolocationUseCase, localStorage: LocalStorage) {
        self.mainRepository = mainRepository
        self.locationUseCase = locationUseCase
        self.localStorage = localStorage
    }
}

extension MainInteractorImpl: MainInteractor {
    func fetchWeatherInfo(completion: @escaping (Result<WeatherInfo, MoyaError>) -> Void) {
        guard let coordinate = locationUseCase.coordinates else { return } 
        mainRepository.fetchWeatherInfo(location: coordinate) { (result) in
            switch result {
            case .success(let weatherInfo):
                if let weather = weatherInfo.toDomain() {
                    try? self.localStorage.set(object: weather, forKey: .fetchedWeatherInfo)
                    completion(.success(weather))
                } else {
                    guard let weather = self.getStoredWeather() else { fatalError("Can't parse weather info!") }
                    completion(.success(weather))
                }
            case .failure:
                guard let weather = self.getStoredWeather() else { fatalError("Can't parse weather info!") }
                completion(.success(weather))
            }
        }
    }

    func fetchDailyForecast(completion: @escaping (Result<DailyForecast, MoyaError>) -> Void) {
        guard let coordinate = locationUseCase.coordinates else { return }
        mainRepository.fetchDailyForecast(location: coordinate) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dailyForecast):
                if let forecast = dailyForecast.toDomain() {
                    try? self.localStorage.set(object: forecast, forKey: .fetchedForecast)
                    completion(.success(forecast))
                } else {
                    guard let forecast = self.getStoredForecast() else { fatalError("Can't parse forecast!") }
                    completion(.success(forecast))
                }
            case .failure:
                guard let forecast = self.getStoredForecast() else { fatalError("Can't parse forecast!") }
                completion(.success(forecast))
            }
        }
    }
}

private extension MainInteractorImpl {
    func getStoredWeather() -> WeatherInfo? {
        return try? localStorage.get(objectType: WeatherInfo.self, forKey: .fetchedWeatherInfo)
    }

    func getStoredForecast() -> DailyForecast? {
        return try? localStorage.get(objectType: DailyForecast.self, forKey: .fetchedForecast)
    }
}
