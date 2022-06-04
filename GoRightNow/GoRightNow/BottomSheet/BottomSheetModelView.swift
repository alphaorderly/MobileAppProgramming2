//
// Created by jeonggyunyun on 2022/05/15.
//

import SwiftUI
import BottomSheetSwiftUI

class BottomSheetModelView: ObservableObject {
    @Published var model: BottomSheetModel = BottomSheetModel() {
        didSet {
            if model.isInSetting {
                storeInUserDefaults()
            }
        }
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(model.storedPosStr), forKey: "SheetPos")
    }
    
    private func restoreFromUserDefault() {
        if let jsonData = UserDefaults.standard.data(forKey: "SheetPos"),
           let decodedPosition = try? JSONDecoder().decode(String.self, from: jsonData) {
            model.storedPosStr = decodedPosition
        }
    }
    
    init() {
        restoreFromUserDefault()
        replacePosDat()
        print("loaded SheetPosition UserDefault")
    }
    
    var position: BottomSheetPosition {
        get {
            model.bottomSheetPosition
        }

        set {
            model.bottomSheetPosition = newValue
        }
    }

    func replacePosDat() {
        model.replacePosDat()
    }
    
    func toggleSettingMode() {
        model.toggleSettingMode()
    }
}
