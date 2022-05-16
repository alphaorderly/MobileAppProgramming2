//
//  GoRightNowApp.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI

@main
struct GoRightNowApp: App {
    var body: some Scene {
        WindowGroup {
            let modelView = GoRightNowModelView()
            let selectView = ViewSelect()
            GoRightNow(modelView: modelView, selectView: selectView)
        }
    }
}
