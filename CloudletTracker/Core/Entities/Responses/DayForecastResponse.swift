//
//  DayForecastResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class DayForecastResponse: ImmutableMappable {
    let dateTime: Int?
    let weatherMainInfo: WeatherMainInfoResponse?
    let weatherGeneralInfo: WeatherGeneralInfoResponse?
    let clouds: Int?
    let windInfo: WindInfoResponse?
    let date: String?

    required init(map: Map) throws {
        dateTime = try? map.value("dt")
        weatherMainInfo = try? map.value("main")
        weatherGeneralInfo = try? map.value("weather")
        clouds = try? map.value("clouds.all")
        windInfo = try? map.value("wind")
        date = try? map.value("dt_txt")
    }

    func mapping(map: Map) {
        dateTime >>> map["dt"]
        weatherMainInfo >>> map["main"]
        weatherGeneralInfo >>> map["weather"]
        clouds >>> map["clouds.all"]
        windInfo >>> map["wind"]
        date >>> map["dt_txt"]
    }
}

extension DayForecastResponse {
    func toDomain() -> DayForecast? {
        guard
            let date = date,
            let weatherMainInfo = weatherMainInfo?.toDomain() else {
                return nil
        }
        return DayForecast(
            dateTime: dateTime,
            weatherMainInfo: weatherMainInfo,
            weatherGeneralInfo: weatherGeneralInfo?.toDomain(),
            clouds: clouds,
            windInfo: windInfo?.toDomain(),
            date: date
        )
    }
}
