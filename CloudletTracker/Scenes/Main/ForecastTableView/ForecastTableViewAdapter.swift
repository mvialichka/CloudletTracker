//
//  ForecastTableViewAdapter.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/13/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

final class ForecastTableViewAdapter: NSObject {
    private var forecastItems: [ForecastTableViewItem] = []

    override init() {
        super.init()
    }

    func updateForecastItems(_ items: [ForecastTableViewItem]) {
        forecastItems = items
    }
}

extension ForecastTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastItem = forecastItems[indexPath.row]
        let cell: ForecastTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.display(item: forecastItem)
        return cell
    }
}

extension ForecastTableViewAdapter: UITableViewDelegate { }
