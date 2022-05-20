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
	@StateObject var bottomSheetModelView = BottomSheetModelView()
    @StateObject var mapModelView = MapModelView()
    
    
    var body: some Scene {
        WindowGroup {
            GoRightNow()
                .environmentObject(modelView)
                .environmentObject(selectView)
                .environmentObject(plannerView)
                .environmentObject(bottomSheetModelView)
                    .environmentObject(mapModelView)
        }
    }
}
