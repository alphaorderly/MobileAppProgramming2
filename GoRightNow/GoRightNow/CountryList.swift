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
                    // 한국발 입국정보를 없애서 일단 임시로 저렇게 해두었습니다 ;ㅁ;
                    ListTile(name: data.name, immg: data.immigInfo, immgkor: "데이터 없음", isocode: data.iso_alp2)
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
            destination: CountryDetailView(countryName: name, immigInfo: immg, immigInfoForKor: immgkor, isoCode: isocode),
            label:  {
                HStack {
                    FlagImage(iso2: isocode)
                        .frame(width: 90, height: 60)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 0))
                    HStack(alignment: .firstTextBaseline) {
                        Spacer()
                        Text(name)
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                }
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .shadow(radius: 2)
                .opacity(0.8)
            }
        )
        .navigationBarTitle("메인화면 돌아가기")
    }
}

struct FlagImage: View {
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
