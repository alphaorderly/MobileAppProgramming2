//
//  ContentView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.∫
//

import SwiftUI
import Alamofire
import BottomSheetSwiftUI

// 모든 모델뷰는 여기서 관리함.
struct GoRightNow: View {
    @EnvironmentObject var modelView: GoRightNowModelView;
    @EnvironmentObject var selectView: ViewSelect;
    @EnvironmentObject var plannerModelView: PlannerModelView;
    @EnvironmentObject var bottomSheetModelView: BottomSheetModelView;
    @State private var isSheetPresented = true
    /*
     ObservedObject는 $를 붙혀 State와 같이 사용가능 -> @Binding을 통해 call by reference와 같은 효과 누릴수 있음.
     */

    @State var locations = [
        Location(title: "San Francisco", latitude: 37.7749, longitude: -122.4194),
        Location(title: "New York", latitude: 40.7128, longitude: -74.0060),
        Location(title: "KNU", latitude: 35.8882118, longitude: 128.6109155)
    ]

    let backgroundColors: [Color] = [Color(red: 0.28, green: 0.28, blue: 0.53), Color(red: 1, green: 0.69, blue: 0.26)]
    let words: [String] = ["Hello", "World", "Swift", "UI", "Fuck", "Appcode", "Xcode", "iPhone", "MacOs", "iPad", "Macbook", "AppleWatch", "ios", "watchOs", "ipadOs"]

    var body: some View {
        VStack{
            MapView(locations: locations)
        }
                .bottomSheet(bottomSheetPosition: $bottomSheetModelView.model.bottomSheetPosition, options: [.appleScrollBehavior], headerContent: {
                    BottomSheetHeader(bottomSheetView: bottomSheetModelView, modelView: modelView)
                }) {
                    Text("Hello").padding()
                }
    }
}



