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
        Text("Current version : \(version)")
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(version: "Test")
    }
}
