//
//  WeatherInfo.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

struct WeatherInfo {
    let location: Location?
    let weatherGeneralInfo: WeatherGeneralInfo?
    let base: String?
    let weatherMainInfo: WeatherMainInfo
    let windInfo: WindInfo
    let clouds: Int?
    let dateTime: Int?
    let sunriseInfo: SunriseInfo
    let timezone: Int?
    let id: Int
    let name: String?
    let cod: Int?
}

extension WeatherInfo: Encodable {
    enum CodingKeys: CodingKey {
        case location
        case weatherGeneral
        case base
        case weatherMain
        case wind
        case clouds
        case dateTime
        case sunrise
        case timezone
        case id
        case name
        case cod
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(weatherMainInfo, forKey: .weatherMain)
        try container.encode(windInfo, forKey: .wind)
        try container.encode(sunriseInfo, forKey: .sunrise)
        try container.encode(id, forKey: .id)
    }
}

extension WeatherInfo: Decodable {
    enum WeatherInfoCodingError: Error {
        case decoding
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        location = try? container.decode(Location.self, forKey: .location)
        weatherGeneralInfo = try? container.decode(WeatherGeneralInfo.self, forKey: .weatherGeneral)
        base = try? container.decode(String.self, forKey: .base)
        weatherMainInfo = try container.decode(WeatherMainInfo.self, forKey: .weatherMain)
        windInfo = try container.decode(WindInfo.self, forKey: .wind)
        clouds = try? container.decode(Int.self, forKey: .clouds)
        dateTime = try? container.decode(Int.self, forKey: .dateTime)
        sunriseInfo = try container.decode(SunriseInfo.self, forKey: .sunrise)
        timezone = try? container.decode(Int.self, forKey: .timezone)
        id = try container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        cod = try? container.decode(Int.self, forKey: .cod)
    }
}
