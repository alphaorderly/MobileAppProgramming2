//
//  ContentView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.∫
//

import SwiftUI
import Alamofire
import BottomSheetSwiftUI

// 모든 모델뷰는 여기서 관리함.
struct GoRightNow: View {
    @EnvironmentObject var modelView: GoRightNowModelView;
    @EnvironmentObject var selectView: ViewSelect;
    @EnvironmentObject var plannerModelView: PlannerModelView;
    /*
     ObservedObject는 $를 붙혀 State와 같이 사용가능 -> @Binding을 통해 call by reference와 같은 효과 누릴수 있음.
     */

    var body: some View {
        switch selectView.selectedView {
        case .mainList:
            MainApp()
        case .planner:
            PlannerView()
        case .setting:
            SettingView(version: modelView.model.version)
        }
    }
}


