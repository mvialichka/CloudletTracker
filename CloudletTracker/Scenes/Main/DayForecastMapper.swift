//
//  DayForecastMapper.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/14/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Foundation

final class DayForecastMapper {
    func mapDayForecastToItem(_ dayForecast: DayForecast) -> ForecastTableViewItem? {
        return ForecastTableViewItem(
            date: dayForecast.date,
            temperature: "\(dayForecast.weatherMainInfo.temperature) \u{00B0}F",
            pressure: "\(dayForecast.weatherMainInfo.pressure) mm"
        )
    }
}
