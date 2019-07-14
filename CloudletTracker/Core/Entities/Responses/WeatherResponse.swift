//
//  WeatherResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class WeatherResponse: ImmutableMappable {
    let coordinates: LocationResponse?
    let weatherGeneralInfo: WeatherGeneralInfoResponse?
    let base: String?
    let weatherMainInfo: WeatherMainInfoResponse?
    let windInfo: WindInfoResponse?
    let clouds: Int?
    let dt: Int?
    let sunriseInfo: SunriseInfoResponse?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?

    required init(map: Map) throws {
        coordinates = try? map.value("coord")
        weatherGeneralInfo = try? map.value("weather")
        base = try? map.value("base")
        weatherMainInfo = try? map.value("main")
        windInfo = try? map.value("wind")
        clouds = try? map.value("clouds")
        dt = try? map.value("dt")
        sunriseInfo = try? map.value("sys")
        timezone = try? map.value("timezone")
        id = try? map.value("id")
        name = try? map.value("name")
        cod = try? map.value("cod")
    }

    func mapping(map: Map) {
        coordinates >>> map["coord"]
        weatherGeneralInfo >>> map["weather"]
        base >>> map["base"]
        weatherMainInfo >>> map["main"]
        windInfo >>> map["wind"]
        clouds >>> map["clouds"]
        dt >>> map["dt"]
        sunriseInfo >>> map["sys"]
        timezone >>> map["timezone"]
        id >>> map["id"]
        name >>> map["name"]
        cod >>> map["cod"]
    }
}

extension WeatherResponse {
    func toDomain() -> WeatherInfo? {
        guard
            let id = id,
            let wheatherMainInfo = weatherMainInfo?.toDomain(),
            let windInfo = windInfo?.toDomain(),
            let sunriseInfo = sunriseInfo?.toDomain() else {
                return nil
        }
        return WeatherInfo(
            location: coordinates?.toDomain(),
            weatherGeneralInfo: weatherGeneralInfo?.toDomain(),
            base: base,
            weatherMainInfo: wheatherMainInfo,
            windInfo: windInfo,
            clouds: clouds,
            dateTime: dt,
            sunriseInfo: sunriseInfo,
            timezone: timezone,
            id: id,
            name: name,
            cod: cod
        )
    }
}
