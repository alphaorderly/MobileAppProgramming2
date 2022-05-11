//
//  CountryList.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/02.
//

import SwiftUI

struct CountryList: View {
    var countries: [GoRightNowModel.Country]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(countries, id:\.self) { data in
                    ListTile(name: data.name, immg: data.immigInfo, immgkor: data.immigInfoForKor, isocode: data.iso_alp2)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    }
            }
        }
    }
}

struct ListTile:View{
    var name: String
    var immg: String
    var immgkor: String
    var isocode: String
    
    var body: some View {
        NavigationLink (
            destination: CountryDetailView(countryName: name, immigInfo: immg, immigInfoForKor: immgkor),
            label:  {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(isocode)")
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    Text(name)
                    Spacer()
                }
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .shadow(radius: 2)
                .opacity(0.8)
            }
        )
        .navigationBarTitle("메인화면 돌아가기")
    }
}

