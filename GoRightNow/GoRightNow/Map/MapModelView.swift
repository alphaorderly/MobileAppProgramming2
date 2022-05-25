//
// Created by jeonggyunyun on 2022/05/20.
//

import SwiftUI
import MapKit

class MapModelView: ObservableObject {
    @Published var model: MapModel = MapModel()

    func makePin(location: Location, countryInfo: GoRightNowModel.Country){
        let pin = CustomAnnotationModel()
        pin.coordinate = location.center
        pin.title = location.title
        pin.countryInfo = countryInfo

        model.mapView.removeAnnotations(model.mapView.annotations)
        model.mapView.addAnnotation(pin)
    }
}
