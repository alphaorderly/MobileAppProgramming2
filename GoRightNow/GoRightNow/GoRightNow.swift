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
        ZStack {
            VStack {
                SearchBar(text: $modelView.model.textInput)                        // 국가 검색창
                    .padding()
                Spacer()
                Text(modelView.model.textInput)                                    // 검색창에 입력된 값 확인용 임시 View
                Spacer()
            }
        }
        .contentShape(Rectangle())
        .task() {
            // 뷰가 Appear됨과 동시에 비동기적으로 실행되는 Task
            await modelView.getCountryData()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = GoRightNowModelView()
        GoRightNow(modelView: modelView)
    }
}
