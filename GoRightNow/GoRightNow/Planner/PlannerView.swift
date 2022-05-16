//
//  PlannerView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import SwiftUI

struct PlannerView: View {
    @ObservedObject var mainModelView: GoRightNowModelView;
    @ObservedObject var selectView: ViewSelect
    @ObservedObject var plannerModelView: PlannerModelView

    var body: some View {
        NavigationView {
            ZStack {
                ThemeData.background
                
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                mainModelView.model.sideMenu = !mainModelView.model.sideMenu
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                        }
                        Spacer()
                    }
                    Text("I'm in the plnner view")
                    Spacer()
                }
                .onAppear {
                    mainModelView.model.sideMenu = false
                }
                
                if mainModelView.model.sideMenu {
                    GeometryReader { geometry in
                        HStack (spacing: 0){
                            SideMenu(menu: $mainModelView.model.sideMenu, select: $selectView.selectedView, version: mainModelView.model.version, geometry: geometry)
                            Color.init(red: 0, green: 0, blue: 0, opacity: 0)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    // 사이드바 다시 집어 넣기 위한 코드
                                    withAnimation {
                                        mainModelView.model.sideMenu = false
                                        print(mainModelView.model.sideMenu)
                                }
                            }
                        }
                    }
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)).animation(.linear(duration: 0.2)))
                    .zIndex(100)
                    // Animation 구현 및 Sidebar가 절대로 뒤에 가지 않도록 설정
                }
            }
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true).navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
        }
    }
}
