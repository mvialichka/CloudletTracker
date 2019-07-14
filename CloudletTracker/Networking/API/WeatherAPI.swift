//
//  WeatherAPI.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Moya

enum WeatherAPI {
    case weather(location: Location)
    case dailyForecast(location: Location)
}

extension WeatherAPI: TargetType {
    var baseURL: URL { return URL(string: "https://api.openweathermap.org/data/2.5")! }

    var path: String {
        switch self {
        case .weather:
            return "/weather"
        case .dailyForecast:
            return "/forecast"
        }
    }

    var method: Method {
        switch self {
        case .weather, .dailyForecast:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .weather(let location):
            return [
                "lat": location.latitude,
                "lon": location.longitude
            ]
        case .dailyForecast(let location):
            return [
                "lat": location.latitude,
                "lon": location.longitude,
            ]
        }
    }

    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return .requestPlain
    }

    var sampleData: Data { return Data() }
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
