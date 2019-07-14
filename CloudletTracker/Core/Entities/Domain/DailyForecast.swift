//
//  DailyForecast.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

struct DailyForecast {
    let cod: String?
    let message: Int?
    let numberOfForecasts: Int?
    let forecastsList: [DayForecast]
}

extension DailyForecast: Encodable {
    enum CodingKeys: CodingKey {
        case cod
        case message
        case numberOfForecasts
        case forecastsList
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(forecastsList, forKey: .forecastsList)
    }
}

extension DailyForecast: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cod = try? container.decode(String.self, forKey: .cod)
        message = try? container.decode(Int.self, forKey: .message)
        numberOfForecasts = try? container.decode(Int.self, forKey: .numberOfForecasts)
        forecastsList = try container.decode([DayForecast].self, forKey: .forecastsList)

    }
}
