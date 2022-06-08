//
//  Theme.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/13.
//

import SwiftUI

struct ThemeData {
    static var background: some View {
        LinearGradient(gradient: Gradient(colors: [Color.init(red: 168/255, green: 200/255, blue: 249/255, opacity: 1.0), Color.init(red: 168/255, green: 200/255, blue: 249/255, opacity: 0.5)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
    }
}
