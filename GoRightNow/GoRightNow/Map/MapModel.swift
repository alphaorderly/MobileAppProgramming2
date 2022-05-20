//
// Created by jeonggyunyun on 2022/05/20.
//

import MapKit
import SwiftUI

struct MapModel {
    let mapView: MKMapView = MKMapView(frame: .zero)

    @State var locations = [
        Location(title: "San Francisco", latitude: 37.7749, longitude: -122.4194),
        Location(title: "New York", latitude: 40.7128, longitude: -74.0060),
//        Location(title: "KNU", latitude: 35.8882118, longitude: 128.6109155)
    ]

}
