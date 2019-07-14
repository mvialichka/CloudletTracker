//
//  WeatherGeneralInfo.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

struct WeatherGeneralInfo {
    let id: Int
    let main: String?
    let description: String?
    let icon: String?
}

extension WeatherGeneralInfo: Encodable {
    enum CodingKeys: CodingKey {
        case id
        case main
        case description
        case icon
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}

extension WeatherGeneralInfo: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        main = try? container.decode(String.self, forKey: .main)
        description = try? container.decode(String.self, forKey: .description)
        icon = try? container.decode(String.self, forKey: .icon)
    }
}
