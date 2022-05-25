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
        pin.subtitle = getInfo(countryInfo.alarmLevel)


        model.mapView.removeAnnotations(model.mapView.annotations)
        model.mapView.addAnnotation(pin)
        model.mapView.selectAnnotation(pin, animated: true)
    }

    func getInfo(_ type: Int?) -> String {
        switch type {
        case 0:
            return "특별 여행 주의보 국가"
        case 1:
            return ("여행 유의 국가")
        case 2:
            return ("여행 자제 국가")
        case 3:
            return ("출국 권고 국가")
        case 4:
            return ("여행 금지 국가")
        default:
            return ("특별 여행 주의보 국가")
        }
    }
}
