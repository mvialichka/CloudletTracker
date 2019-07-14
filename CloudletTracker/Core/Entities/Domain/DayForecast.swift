//
//  DayForecast.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

struct DayForecast {
    let dateTime: Int?
    let weatherMainInfo: WeatherMainInfo
    let weatherGeneralInfo: WeatherGeneralInfo?
    let clouds: Int?
    let windInfo: WindInfo?
    let date: String
}

extension DayForecast: Encodable {
    enum CodingKeys: CodingKey {
        case dateTime
        case weatherMain
        case weatherGeneral
        case clouds
        case wind
        case date
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(weatherMainInfo, forKey: .weatherMain)
        try container.encode(date, forKey: .date)
    }
}

extension DayForecast: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try? container.decode(Int.self, forKey: .dateTime)
        weatherMainInfo = try container.decode(WeatherMainInfo.self, forKey: .weatherMain)
        weatherGeneralInfo = try? container.decode(WeatherGeneralInfo.self, forKey: .weatherGeneral)
        clouds = try? container.decode(Int.self, forKey: .clouds)
        windInfo = try? container.decode(WindInfo.self, forKey: .wind)
        date = try container.decode(String.self, forKey: .date)
    }
}
