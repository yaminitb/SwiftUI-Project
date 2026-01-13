//
//  MKCoordinateRegion+Extension.swift
//  LoginApp
//
//  Created by MacMini on 08/01/26.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 29.726819, longitude: -95.393692), latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
