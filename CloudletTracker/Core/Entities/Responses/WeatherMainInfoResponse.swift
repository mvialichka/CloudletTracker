//
//  WeatherMainInfoResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class WeatherMainInfoResponse: ImmutableMappable {
    let temperature: Double?
    let pressure: Double?
    let humidity: Double?
    let minTemperature: Double?
    let maxTemperature: Double?

    required init(map: Map) throws {
        temperature = try? map.value("temp")
        pressure = try? map.value("pressure")
        humidity = try? map.value("humidity")
        minTemperature = try? map.value("temp_min")
        maxTemperature = try? map.value("temp_max")
    }

    func mapping(map: Map) {
        temperature >>> map["temp"]
        pressure >>> map["pressure"]
        humidity >>> map["humidity"]
        minTemperature >>> map["temp_min"]
        maxTemperature >>> map["temp_max"]
    }
}

extension WeatherMainInfoResponse {
    func toDomain() -> WeatherMainInfo? {
        guard
            let temperature = temperature,
            let pressure = pressure else {
                return nil
        }
        return WeatherMainInfo(
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
        minTemperature: minTemperature,
        maxTemperature: maxTemperature
        )
    }
}
