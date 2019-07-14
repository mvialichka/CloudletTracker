//
//  WindInfo.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

struct WindInfo {
    let speed: Double
    let degrees: Double?
}

extension WindInfo: Encodable {
    enum CodingKeys: CodingKey {
        case speed
        case degrees
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(speed, forKey: .speed)
    }
}

extension WindInfo: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try container.decode(Double.self, forKey: .speed)
        degrees = try? container.decode(Double.self, forKey: .degrees)
    }
}


