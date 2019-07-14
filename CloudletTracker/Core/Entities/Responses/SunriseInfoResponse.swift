//
//  SunriseInfoResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class SunriseInfoResponse: ImmutableMappable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?

    required init(map: Map) throws {
        type = try? map.value("type")
        id = try? map.value("id")
        message = try? map.value("message")
        country = try? map.value("country")
        sunrise = try? map.value("sunrise")
        sunset = try? map.value("sunset")
    }

    func mapping(map: Map) {
        type >>> map["type"]
        id >>> map["id"]
        message >>> map["message"]
        country >>> map["country"]
        sunrise >>> map["sunrise"]
        sunset >>> map["sunset"]
    }
}

extension SunriseInfoResponse {
    func toDomain() -> SunriseInfo? {
        guard
            let id = id,
            let sunrise = sunrise,
            let sunset = sunset else {
                return nil
        }
        return SunriseInfo(
            type: type,
            id: id,
            message: message,
            country: country,
            sunrise: sunrise,
            sunset: sunset
        )
    }
}
