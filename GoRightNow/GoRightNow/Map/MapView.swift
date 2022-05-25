
import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @EnvironmentObject var mapModelView: MapModelView

    func makeUIView(context: Context) -> MKMapView {
        let mapView = mapModelView.model.mapView
        mapView.mapType = .hybridFlyover
        // set coordinates (lat lon)
        let coords = CLLocationCoordinate2D(latitude: 53.062640, longitude: -2.968900)

        // set span (radius of points)
        let span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)

        // set region
        let region = MKCoordinateRegion(center: coords, span: span)

        // set the view
        mapView.setRegion(region, animated: true)

        return mapView
    }

    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self, mapModelView)
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        view.delegate = context.coordinator
    }



    public class MapViewCoordinator: NSObject, MKMapViewDelegate {
        var parentMapView: MapView
        var mapModelView: MapModelView
        var selectedCountry: GoRightNowModel.Country?

        init(_ control: MapView, _ modelView: MapModelView) {
            self.parentMapView = control
            self.mapModelView = modelView
        }


        //Pin이 선택되었을 때 선택된 country를 model에 넘김
        public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            let model = view.annotation as? CustomAnnotationModel
//            mapView.setCenter(model.coordinate, animated: true)
            print("\(model?.countryInfo?.name) injected")
            mapModelView.model.selectedCountry = model?.countryInfo
        }


        //Pin의 버튼이 선택되었을 때 Sheet을 Show하도록 값을 변경
        public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            mapModelView.model.isDetailSheet = true
        }


        //MKAnnotation Pin 설정
        public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"")
            annotationView.isEnabled = true
            annotationView.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }


    }
}
