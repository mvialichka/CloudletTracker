//
//  WindInfoResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class WindInfoResponse: ImmutableMappable {
    let speed: Double?
    let degrees: Double?

    required init(map: Map) throws {
        speed = try? map.value("speed")
        degrees = try? map.value("deg")
    }

    func mapping(map: Map) {
        speed >>> map["speed"]
        degrees >>> map["deg"]
    }
}

extension WindInfoResponse {
    func toDomain() -> WindInfo? {
        guard let speed = speed else { return nil }
        return WindInfo(
            speed: speed,
            degrees: degrees
        )
    }
}
