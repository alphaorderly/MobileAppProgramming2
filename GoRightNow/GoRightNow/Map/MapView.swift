
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @State var locations: [Location]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        // change the map type here
        mapView.mapType = .hybridFlyover

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
    }
}
