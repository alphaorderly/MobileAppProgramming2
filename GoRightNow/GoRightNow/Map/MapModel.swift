//
// Created by jeonggyunyun on 2022/05/20.
//

import MapKit
import SwiftUI

struct MapModel {
    let mapView: MKMapView = MKMapView(frame: .zero)

    var isDetailSheet = false

    var selectedCountry: GoRightNowModel.Country?
}
