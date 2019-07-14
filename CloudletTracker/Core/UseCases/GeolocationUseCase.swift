//
//  GeolocationUseCase.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import CoreLocation

final class GeolocationUseCase: NSObject {
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    var coordinates: Location?
}

extension GeolocationUseCase: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {
            return
        }
        coordinates = mapCoordinates(location.coordinate)
    }
}

private extension GeolocationUseCase {
    func mapCoordinates(_ coordinates: CLLocationCoordinate2D) -> Location {
        return Location(
            latitude: Double(coordinates.latitude),
            longitude: Double(coordinates.longitude)
        )
    }
}
