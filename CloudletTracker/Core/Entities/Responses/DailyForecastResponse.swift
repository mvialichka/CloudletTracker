//
//  DailyForecastResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class DailyForecastResponse: ImmutableMappable {
    let cod: String?
    let message: Int?
    let numberOfForecasts: Int?
    let forecastsList: [DayForecastResponse]?

    required init(map: Map) throws {
        cod = try? map.value("cod")
        message = try? map.value("message")
        numberOfForecasts = try? map.value("cnt")
        forecastsList = try? map.value("list")
    }

    func mapping(map: Map) {
        cod >>> map["cod"]
        message >>> map["message"]
        numberOfForecasts >>> map["cnt"]
        forecastsList >>> map["list"]
    }
}

extension DailyForecastResponse {
    func toDomain() -> DailyForecast? {
        guard
            let cod = cod,
            let forecastsList = forecastsList else {
                return nil
        }
        return DailyForecast(
            cod: cod,
            message: message,
            numberOfForecasts: numberOfForecasts,
            forecastsList: forecastsList.compactMap { $0.toDomain() }
        )
    }
}
