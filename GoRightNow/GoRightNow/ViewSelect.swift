//
//  ViewSelect.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import Foundation

enum ViewList {
    case mainList
    case planner
}

class ViewSelect: ObservableObject {
    @Published var selectedView: ViewList
    
    init() {
        selectedView = .mainList
    }
}
