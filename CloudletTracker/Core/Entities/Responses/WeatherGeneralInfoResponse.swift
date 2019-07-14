//
//  WeatherGeneralInfoResponse.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import ObjectMapper

final class WeatherGeneralInfoResponse: ImmutableMappable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?

    required init(map: Map) throws {
        id = try? map.value("id")
        main = try? map.value("main")
        description = try? map.value("description")
        icon = try? map.value("icon")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        main >>> map["main"]
        description >>> map["description"]
        icon >>> map["icon"]
    }
}

extension WeatherGeneralInfoResponse {
    func toDomain() -> WeatherGeneralInfo? {
        guard let id = id else { return nil }
        return WeatherGeneralInfo(
            id: id,
            main: main,
            description: description,
            icon: icon
        )
    }
}
