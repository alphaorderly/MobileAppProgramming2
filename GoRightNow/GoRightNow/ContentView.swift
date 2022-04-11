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
        }
    }
}

struct SearchBar: View {
    @Binding var textInput: String
    @State var editText: Bool = false
    
    var body: some View {
        HStack {
            TextField("국가명을 입력해주세요", text: self.$textInput)
                .padding(15)
                .padding(.horizontal, 15)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .overlay(
                    HStack {
                        Spacer()
                        if self.editText {
                            Button(action: {
                                self.editText = false
                                self.textInput = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .padding()
                            }
                        } else {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.black))
                                .padding()
                        }
                    }
                )
                .onTapGesture {
                    self.editText = true
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(searchText: "")
    }
}
