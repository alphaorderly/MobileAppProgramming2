//
//  ContentView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.∫
//

import SwiftUI
import Alamofire

// 모든 모델뷰는 여기서 관리함.
struct GoRightNow: View {
    @ObservedObject var modelView: GoRightNowModelView;
    @ObservedObject var selectView: ViewSelect;
    @ObservedObject var plannerModelView: PlannerModelView;
    
    /*
     ObservedObject는 $를 붙혀 State와 같이 사용가능 -> @Binding을 통해 call by reference와 같은 효과 누릴수 있음.
     */
    
    var body: some View {
        switch selectView.selectedView {
        case .mainList:
            MainApp(modelView: modelView, selectView: selectView)
        case .planner:
            PlannerView(mainModelView: modelView, selectView: selectView, plannerModelView: plannerModelView)
        }
    }
}

struct MainApp: View {
    @ObservedObject var modelView: GoRightNowModelView;
    @ObservedObject var selectView: ViewSelect
    
    var body: some View {
        // 이 화면에서 다른 화면으로 넘어갈수 있게 설정해두는것.
        NavigationView {
            ZStack {
                // 배경색
                ThemeData.background

                if(modelView.model.gotData == 0) {
                    VStack {
                        Text("입국정보 가져오는 중")
                        ProgressView()
                    }
                } else {
                    VStack {
                        SearchBar(text: $modelView.model.textInput, menu: $modelView.model.sideMenu)                        // 국가 검색창
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                        CountryList(countries: modelView.model.countryList)
                        Spacer()
                    }
                    .contentShape(Rectangle()) // 사이드바 집어넣게 하기 위해 위 VStack을 터치 가능한 객체로 만듦

                    // Model의 sideMenu 값에 따라 sidebar 표시 여부 결정
                    if modelView.model.sideMenu {
                        GeometryReader { geometry in
                            HStack (spacing: 0){
                                SideMenu(menu: $modelView.model.sideMenu, select: $selectView.selectedView, version: modelView.model.version, geometry: geometry)
                                Color.init(red: 0, green: 0, blue: 0, opacity: 0)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        // 사이드바 다시 집어 넣기 위한 코드
                                        withAnimation {
                                            if modelView.model.sideMenu  {
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
            }
            .onAppear() { modelView.model.sideMenu = false }
            // 뷰 이동시마다 값을 받아오지 않도록 설정
            .task { if modelView.model.gotData == 0 {
                    await modelView.getCountryData()
                    modelView.model.gotData = 1
                }
            }
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true).navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
            // Navigation 구현하고도 위에 제목이 따로 나오지 않게 설정
        }
    }
}

