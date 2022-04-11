//
//  GoRightNowApp.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI

@main
struct GoRightNowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
