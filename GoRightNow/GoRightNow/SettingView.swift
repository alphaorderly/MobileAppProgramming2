//
//  VersionView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/30.
//

import SwiftUI

struct SettingView: View {
    var version: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.init(red: 255/255, green: 98/255, blue: 0.0, opacity: 1.0), Color.init(red: 253/255, green: 147/255, blue: 70/255, opacity: 0.8)]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Current version : \(version)")
                Spacer()
            }
        }
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(version: "Test")
    }
}
