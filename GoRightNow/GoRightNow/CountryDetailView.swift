//
//  CountryDetailView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/04.
//

import SwiftUI

struct CountryDetailView: View {
    var countryName: String
    var immigInfo: String
    var immigInfoForKor: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.init(red: 255/255, green: 98/255, blue: 0.0, opacity: 1.0), Color.init(red: 253/255, green: 147/255, blue: 70/255, opacity: 0.8)]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("")
                        .navigationBarTitle(countryName)
                    Spacer()
                    Text(immigInfo)
                    Spacer()
                    Text(immigInfoForKor)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

