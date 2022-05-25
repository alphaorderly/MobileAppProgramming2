
import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @EnvironmentObject var mapModelView: MapModelView

    func makeUIView(context: Context) -> MKMapView {
        let mapView = mapModelView.model.mapView
        let coords = CLLocationCoordinate2D(latitude: 53.062640, longitude: -2.968900)
        let span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
        let region = MKCoordinateRegion(center: coords, span: span)

        mapView.mapType = .hybridFlyover
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
            mapModelView.model.selectedCountry = model?.countryInfo
        }


        //Pin의 버튼이 선택되었을 때 Sheet을 Show하도록 값을 변경
        public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            mapModelView.model.isDetailSheet = true
        }


        //MKAnnotation Pin 설정
        public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"")
            let model = annotation as? CustomAnnotationModel
            annotationView.isEnabled = true
            annotationView.canShowCallout = true

            //Pin 양 버튼 이미지 설정
            let btn = UIButton(type: .detailDisclosure)
            let image = UIButton(type: .custom)
            if UIImage(named: (model?.countryInfo!.iso_alp2)!) != nil {
                image.setImage(UIImage(named: (model?.countryInfo!.iso_alp2)!), for: UIControl.State.disabled)
            } else {
                let data = urlToImage(strUrl: model!.countryInfo!.flagImageURL)
                image.setImage(data, for: UIControl.State.normal)

            }
            image.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            image.isEnabled = false

            annotationView.rightCalloutAccessoryView = btn
            annotationView.leftCalloutAccessoryView = image


            return annotationView
        }

        //URL을 ImageData로 변경하는 function
        func urlToImage(strUrl: String) -> UIImage? {
            if strUrl.isEmpty || strUrl.count == 0{
                return nil
            }
            do {
                let url = URL(string: strUrl)

                if url != nil {
                    let data = try Data(contentsOf: url!)
                    return UIImage(data: data)
                }
            } catch(let error) {
                print(error)
            }
            return nil
        }
    }

}
