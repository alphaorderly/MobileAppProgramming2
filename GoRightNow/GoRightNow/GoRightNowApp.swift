//
//  GoRightNowApp.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI

@main
struct GoRightNowApp: App {
    @StateObject var modelView = GoRightNowModelView()
    @StateObject var selectView = ViewSelect()
    @StateObject var plannerView = PlannerModelView()
    
    
    var body: some Scene {
        WindowGroup {
            GoRightNow()
                .environmentObject(modelView)
                .environmentObject(selectView)
                .environmentObject(plannerView)
        }
    }
}
