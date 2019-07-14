//
//  SunriseInfo.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

struct SunriseInfo {
    let type: Int?
    let id: Int
    let message: Double?
    let country: String?
    let sunrise: Int
    let sunset: Int
}

extension SunriseInfo: Encodable {
    enum CodingKeys: CodingKey {
        case type
        case id
        case message
        case country
        case sunrise
        case sunset
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(sunrise, forKey: .sunrise)
        try container.encode(sunset, forKey: .sunset)
    }
}

extension SunriseInfo: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try? container.decode(Int.self, forKey: .type)
        id = try container.decode(Int.self, forKey: .id)
        message = try? container.decode(Double.self, forKey: .message)
        country = try? container.decode(String.self, forKey: .country)
        sunrise = try container.decode(Int.self, forKey: .sunrise)
        sunset = try container.decode(Int.self, forKey: .sunset)
    }
}


