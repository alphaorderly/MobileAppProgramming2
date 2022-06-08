//
// Created by jeonggyunyun on 2022/05/15.
//

import SwiftUI
import BottomSheetSwiftUI

struct BottomSheetModel {
    var storedPosStr: String = "bottom" //UserDefault에 저장되는 리스트 위치
    var temporaryPosStr: String = "bottom" //사용자가 제스처로 조작하는 리스트 위치
    var isInSetting: Bool = false //SettingView에 있을때만 리스트 위치 저장

    var bottomSheetPosition: BottomSheetPosition {
        get {
            if isInSetting {
                return changeStringToPos(val: storedPosStr)
            } else {
                return changeStringToPos(val: temporaryPosStr)
            }
        }
        set {
            if isInSetting {
                storedPosStr = changePosToString(val: newValue)
                replacePosDat()
            } else {
                temporaryPosStr = changePosToString(val: newValue)
            }
        }
    }
    
    mutating func replacePosDat() {
        self.temporaryPosStr = self.storedPosStr
    }
    
    mutating func toggleSettingMode() {
        self.isInSetting.toggle()
    }
    
    private func changeStringToPos(val: String) -> BottomSheetPosition {
        switch val {
        case "bottom":
            return .bottom
        case "middle":
            return .middle
        case "top":
            return .top
        default:
            return .bottom
        }
    }
    
    private func changePosToString(val: BottomSheetPosition) -> String {
        switch val {
        case .bottom:
            return "bottom"
        case .middle:
            return "middle"
        case .top:
            return "top"
        default:
            return "bottom"
        }
    }
}
