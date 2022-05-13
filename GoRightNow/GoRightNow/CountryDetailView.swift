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
    var isoCode: String
    
    var body: some View {
        ZStack {
            ThemeData.background
            VStack {
                Text("")
                    .navigationTitle(countryName)
                ScrollView {
                    FlagImage(iso2: isoCode)
                        .cornerRadius(5)
                        .padding()
                    if immigInfo != "" { CardView("입국 정보", immigInfo) }
                    if immigInfoForKor != "" { CardView("한국인 입국 정보", immigInfoForKor) }
                }
            }
        }
    }
}

struct flag: View {
    let iso2: String
    
    var body: some View {
        if UIImage(named: iso2) != nil {
            Image(iso2)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Text("국기 없음 \(iso2)")
        }
    }
}

// 각 항목에 대한 카드뷰
struct CardView: View {
    var title: String
    var content: String
    
    init(_ title: String, _ content: String) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20).bold())
                Divider()
                Text(content)
            }
            .padding()
        }
        .background(.white.opacity(0.5))
        .cornerRadius(5)
        .padding()
    }
}
