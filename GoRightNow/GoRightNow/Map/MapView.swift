
import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @State var locations: [Location]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        // change the map type here
        mapView.mapType = .hybridFlyover
//        mapView.setCameraZoomRange(CameraZoomRange(), animated: true)

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        for location in locations {
            // make a pins
            let pin = MKPointAnnotation()

            // set the coordinates
            pin.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)

            // set the title
            pin.title = location.title

            // add to map
            view.addAnnotation(pin)
        }

        // set coordinates (lat lon)
        let coords = CLLocationCoordinate2D(latitude: 53.062640, longitude: -2.968900)

        // set span (radius of points)
        let span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)

        // set region
        let region = MKCoordinateRegion(center: coords, span: span)

        // set the view
        view.setRegion(region, animated: true)
    }
}
