//
//  VersionView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/30.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var modelView: GoRightNowModelView;
    @EnvironmentObject var selectView: ViewSelect;
    var version: String
    
    var body: some View {
        ZStack {
            ThemeData.background
            
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
