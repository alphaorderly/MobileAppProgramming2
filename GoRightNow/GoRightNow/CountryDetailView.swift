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
            ThemeData.background
            
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

