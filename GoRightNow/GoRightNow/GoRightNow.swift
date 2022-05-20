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

    var body: some View {
        ZStack{
            MapView(locations: locations)
                    .bottomSheet(bottomSheetPosition: $bottomSheetModelView.model.bottomSheetPosition,
                            options: [.appleScrollBehavior],
                            headerContent: {
                                BottomSheetHeader(bottomSheetView: bottomSheetModelView, modelView: modelView)
                            }) {
                        CountryList(countries: modelView.model.countryList)
                    }
            if modelView.model.sideMenu {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        SideMenu(menu: $modelView.model.sideMenu, select: $selectView.selectedView, version: modelView.model.version, geometry: geometry)
                        Color.init(red: 0, green: 0, blue: 0, opacity: 0)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    // 사이드바 다시 집어 넣기 위한 코드
                                    withAnimation {
                                        if modelView.model.sideMenu {
                                            modelView.model.sideMenu = !modelView.model.sideMenu
                                        }
                                    }
                                }
                    }
                }
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)).animation(.linear(duration: 0.2)))
                        .zIndex(100)
                // Animation 구현 및 Sidebar가 절대로 뒤에 가지 않도록 설정
            }
        }
        .onAppear() {
            modelView.model.sideMenu = false
        }
                // 뷰 이동시마다 값을 받아오지 않도록 설정
                .task {
                    if modelView.model.gotData == 0 {
                        await modelView.getCountryData()
                        modelView.model.gotData = 1
                    }
                }
    }
}


