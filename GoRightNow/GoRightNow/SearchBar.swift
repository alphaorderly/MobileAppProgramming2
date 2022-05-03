//
//  SearchBar.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI

/*
 
 검색창
 
 - textInput : @Binding을 통해 여기서 값 바꿀시 View에서도 값이 바뀜
 - editText  : 현재 사용 여부
 
  사용법 : SearchBar(textInput: ${state변수명}) -> 여기에 입력시 위 변수값이 바뀌게 됨.
 
    padding() 과 함께 사용해야 좀 이쁨.
 
 */

struct SearchBar: View {
    @Binding var text: String
    @Binding var menu: Bool

        @State var editText = false

    var body: some View {
            HStack {
                Button {
                    withAnimation {
                        menu = !menu
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                }
                .padding()
                TextField("국가명을 입력해주세요", text: self.$text)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    .overlay(
                        HStack {
                            Spacer()
                            if self.editText {
                                Button(action: {
                                    self.editText = false
                                    self.text = ""
    
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    
                        })
                            {
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
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 5)
        .opacity(0.8)
    }
}
