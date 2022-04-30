//
//  ContentView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.∫
//

import SwiftUI
import Alamofire

struct GoRightNow: View {
    @ObservedObject var modelView: GoRightNowModelView;
    /*
     ObservedObject는 $를 붙혀 State와 같이 사용가능 -> @Binding을 통해 call by reference와 같은 효과 누릴수 있음.
     */
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBar(text: $modelView.model.textInput, menu: $modelView.model.sideMenu)                        // 국가 검색창
                        .padding()
                    Spacer()
                    Text(modelView.model.textInput)                                    //
                    Spacer()
                }
                .contentShape(Rectangle()) // 사이드바 집어넣게 하기 위해 위 VStack을 터치 가능한 객체로 만듦
                .onTapGesture {
                    // 사이드바 다시 집어 넣기 위한 코드
                    withAnimation {
                        if modelView.model.sideMenu  {
                            modelView.model.sideMenu = !modelView.model.sideMenu
                        }
                    }
                }
                
                // Model의 sideMenu 값에 따라 sidebar 표시 여부 결정
                if modelView.model.sideMenu {
                    SideMenu(menu: $modelView.model.sideMenu, version: modelView.model.version)
                }
            }
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true).navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = GoRightNowModelView()
        GoRightNow(modelView: modelView)
    }
}
