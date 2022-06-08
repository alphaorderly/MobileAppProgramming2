//
// Created by jeonggyunyun on 2022/05/15.
//

import Foundation
import MapKit

struct Location: Hashable {
    var title: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var center: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var span: MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    }

    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: center, span: span)
    }
}
