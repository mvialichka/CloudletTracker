//
//  LocationResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class LocationResponse: ImmutableMappable {
    let latitude: Double?
    let longitude: Double?

    required init(map: Map) throws {
        latitude = try? map.value("lat")
        longitude = try? map.value("lon")
    }

    func mapping(map: Map) {
        latitude >>> map["lat"]
        longitude >>> map["lon"]
    }
}

extension LocationResponse {
    func toDomain() -> Location? {
        guard
            let latitude = latitude,
            let longitude = longitude else {
                return nil
        }
        return Location(
            latitude: latitude,
            longitude: longitude
        )
    }
}
