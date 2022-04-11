//
//  ContentView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var searchText: String = ""
    @State var sidemenuAppear: Bool = false // 버튼을 누르면 사이드 메뉴가 보인다.
    var body: some View {
        ZStack {
            VStack {
                SearchBar(textInput: $searchText, sideMenuAppear: $sidemenuAppear)                   // 국가 검색창
                    .padding()
                Spacer()
                Text(searchText)                                    // 검색창에 입력된 값 확인용 임시 View
                Spacer()
            }
            if sidemenuAppear {
                SideMenu()
                    
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            sidemenuAppear = false
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
