//
// Created by jeonggyunyun on 2022/05/20.
//

import SwiftUI
import MapKit

class MapModelView: ObservableObject {
    @Published var model: MapModel = MapModel()

    var annotationList: [CustomAnnotationModel] = []

    //핀 생성 후 list에 추가
    private func appendCountryPin(country: GoRightNowModel.Country) {
        let pin = CustomAnnotationModel()

        pin.coordinate = country.location!.center //TODO nil
        pin.title = country.location?.title
        pin.countryInfo = country
        pin.subtitle = getStringInfoFromAlarm(country.alarmLevel)
        annotationList.append(pin)
    }

    func selectPinToCountry(country: GoRightNowModel.Country){
        let anno = self.findPinFrom(name: country.name)
        model.mapView.selectAnnotation(anno, animated: true)
    }

    // map에 pin 추가
    private func setPinsToMap() {
        model.mapView.addAnnotations(annotationList)
    }

    // 나라들을 받아서 핀을 생성함
    func makePin(countries: [GoRightNowModel.Country]) {
        for item in countries {
            appendCountryPin(country: item)
        }
        self.setPinsToMap()
    }

    //해당 지역으로 이동
    func goToRegion(_ country: GoRightNowModel.Country) {
        model.mapView.setRegion(country.location!.region, animated: true)
    }

    //TODO Nil
    func findPinFrom(name: String) -> CustomAnnotationModel {
        let first = annotationList.first { annotation in
            annotation.title == name
        }
        print("Found \(first?.title)")
        return first!
    }

    func getStringInfoFromAlarm(_ type: Int?) -> String {
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
