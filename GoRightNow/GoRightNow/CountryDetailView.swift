//
//  CountryDetailView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/04.
//

import SwiftUI

struct CountryDetailView: View {
    var countryName: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.init(red: 255/255, green: 98/255, blue: 0.0, opacity: 1.0), Color.init(red: 253/255, green: 147/255, blue: 70/255, opacity: 0.8)]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("")
                        .navigationBarTitle(countryName)
                    Spacer()
                    Text("해외입국자 대상 별도의 자가격리 의무 등을 부과하고 있지 않으나, 입국 시 열화상 카메라를 통해 37도 이상인 경우 코로나19 검사 실시(자부담)")
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

