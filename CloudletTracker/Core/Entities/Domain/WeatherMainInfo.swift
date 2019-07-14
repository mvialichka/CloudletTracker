//
//  WeatherMainInfo.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

struct WeatherMainInfo {
    let temperature: Double
    let pressure: Double
    let humidity: Double?
    let minTemperature: Double?
    let maxTemperature: Double?
}

extension WeatherMainInfo: Encodable {
    enum CodingKeys: CodingKey {
        case temperature
        case pressure
        case humidity
        case minTemperature
        case maxTemperature
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(pressure, forKey: .pressure)
    }
}

extension WeatherMainInfo: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decode(Double.self, forKey: .temperature)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try? container.decode(Double.self, forKey: .humidity)
        minTemperature = try? container.decode(Double.self, forKey: .minTemperature)
        maxTemperature = try? container.decode(Double.self, forKey: .maxTemperature)
    }
}
