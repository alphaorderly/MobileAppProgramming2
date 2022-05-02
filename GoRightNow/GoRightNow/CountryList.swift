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
                        Divider()
                        ListTile(name: data)
                    }
                Divider()
            }
        }
    }
}

struct ListTile:View{
    var name: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Flag here")
            Spacer()
            Text(name)
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}

struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList()
    }
}
