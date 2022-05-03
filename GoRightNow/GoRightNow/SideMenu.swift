//
//  SideMenu.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI

/*
 
    사이드 메뉴
 
 */

struct SideMenu: View {
    @Binding var menu: Bool
    var version: String
    var geometry: GeometryProxy
    
    var body: some View {
            HStack {
                    VStack {
                            Divider()
                            NavigationLink(
                                destination: SettingView(version: version),
                                label: {
                                    HStack(alignment: .center) {
                                        Image(systemName: "gear")
                                        Text("Setting")
                                    }
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                                }
                            )
                        Divider()
                        Spacer()
                    }
                    .navigationBarTitle("메인화면 돌아가기")
                .padding(16)
                .padding(.top, 100)
                .background(Color(.systemGray6))
                .edgesIgnoringSafeArea([.bottom, .top])
                .shadow(radius:0)
                Button {
                    withAnimation {
                        menu = false
                    }
                } label: {
                    Image(systemName: "arrowtriangle.backward")
                        .font(.system(size: 40, weight: .heavy))
                        .contentShape(Rectangle()) // 사이드바 집어넣게 하기 위해 위 VStack을 터치 가능한 객체로 만듦
                }
                .foregroundColor(.black)
                Spacer()
            }
            .frame(width: geometry.size.width/2, height: geometry.size.height)
            .shadow(radius: 5)
    }
}
