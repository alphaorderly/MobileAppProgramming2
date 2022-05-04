//
//  CountryList.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/02.
//

import SwiftUI

struct CountryList: View {
    var testData = ["Korea", "Japan", "China"]

    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(testData, id:\.self) { data in
                        ListTile(name: data)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    }
            }
        }
    }
}

struct ListTile:View{
    var name: String
    
    var body: some View {
        NavigationLink (
            destination: CountryDetailView(countryName: name),
            label:  {
                HStack(alignment: .firstTextBaseline) {
                    Text("Flag here")
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

struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList()
    }
}
