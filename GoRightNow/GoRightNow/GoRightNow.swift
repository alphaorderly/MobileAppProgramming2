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
    
    var body: some View {
        ZStack {
            VStack {
                SearchBar(text: $modelView.model.textInput, menu: $modelView.model.sideMenu)                        // 국가 검색창
                    .padding()
                Spacer()
                Text(modelView.model.textInput)                                                                     // 검색창에 입력된 값 확인용 임시 View
                Spacer()
            }
            if modelView.model.sideMenu {
                SideMenu()
                    
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            modelView.model.sideMenu = false
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = GoRightNowModelView()
        GoRightNow(modelView: modelView)
    }
}
