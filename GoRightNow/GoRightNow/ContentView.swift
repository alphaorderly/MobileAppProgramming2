//
//  ContentView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var searchText: String
    var body: some View {
        VStack {
            SearchBar(textInput: $searchText)
            Spacer()
            Text(searchText)
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(searchText: "")
    }
}
