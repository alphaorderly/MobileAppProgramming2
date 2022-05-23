//
// Created by jeonggyunyun on 2022/05/20.
//

import SwiftUI
import MapKit

class MapModelView: ObservableObject {
    @Published var model: MapModel = MapModel()

    func makePin(location: Location){
        print("Run1")
        let pin = MKPointAnnotation()
        pin.coordinate = location.center
        pin.title = location.title
//        model.annotationList.append(pin)
        model.mapView.removeAnnotations(model.mapView.annotations)
        model.mapView.addAnnotation(pin)
//        print(model.annotationList)


    }



//    func setAnnotations() {
//        print("Run2")
//        print(model.annotationList)
//        for annotation in model.annotationList {
//            print("Run3")
//            model.mapView.addAnnotation(annotation)
//        }
//    }

}
