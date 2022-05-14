//
//  ContentView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.∫
//

import SwiftUI
import Alamofire
import MapKit
import PartialSheet

struct Location {
    var title: String
    var latitude: Double
    var longitude: Double
}

// 모든 모델뷰는 여기서 관리함.
struct GoRightNow: View {
    @EnvironmentObject var modelView: GoRightNowModelView;
    @EnvironmentObject var selectView: ViewSelect;
    @EnvironmentObject var plannerModelView: PlannerModelView;
    @State private var isSheetPresented = true
    /*
     ObservedObject는 $를 붙혀 State와 같이 사용가능 -> @Binding을 통해 call by reference와 같은 효과 누릴수 있음.
     */

    @State var locations = [
        Location(title: "San Francisco", latitude: 37.7749, longitude: -122.4194),
        Location(title: "New York", latitude: 40.7128, longitude: -74.0060)
    ]

    var body: some View {
        HStack() {
            MapView(locations: locations)
            Spacer()
            PSButton(
                    isPresenting: $isSheetPresented,
                    label: {
                        Text("Display the Partial Sheet")
                    })
                    .padding()
            Spacer()
        }
                .partialSheet(isPresented: $isSheetPresented, content: SheetView.init)
                .navigationViewStyle(StackNavigationViewStyle())
                .attachPartialSheetToRoot()
    }
}

struct SheetView: View {
    @State private var longer: Bool = false
    @State private var text: String = "some text"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                HStack {
                    Spacer()
                    Text("Settings Panel")
                            .font(.headline)
                    Spacer()
                }

                Text("Vestibulum iaculis sagittis sem, vel hendrerit ex. ")
                        .font(.body)
                        .lineLimit(2)

                Toggle(isOn: self.$longer) {
                    Text("Advanced")
                }
            }
                    .padding(0)
                    .frame(height: 50)
            if self.longer {
                VStack {
                    Divider()
                    Spacer()
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vestibulum porttitor ligula quis faucibus. Maecenas auctor tincidunt maximus. Donec lectus dui, fermentum sed orci gravida, porttitor porta dui. ")
                    Spacer()
                }
                        .frame(height: 200)
            }
        }
                .padding(.horizontal, 10)
    }
}

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
        //switch selectView.selectedView {
        //case .mainList:
        //    MainApp()
        //case .planner:
        //    PlannerView()
        }
    }
}



