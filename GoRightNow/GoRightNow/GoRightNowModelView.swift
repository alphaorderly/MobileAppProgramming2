//
//  GoRightNowModelView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/12.
//ß∫

import Foundation
import SwiftUI

class GoRightNowModelView: ObservableObject {
    @Published var model = GoRightNowModel() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(model.infoFontSize), forKey: "InfoFontSize")
    }
    
    private func restoreFromUserDefault() {
        if let jsonData = UserDefaults.standard.data(forKey: "InfoFontSize"),
           let decodedFontSize = try? JSONDecoder().decode(CGFloat.self, from: jsonData) {
            model.infoFontSize = decodedFontSize
        }
    }
    
    init() {
        restoreFromUserDefault()
        print("loaded informationFontSize from UserDefaults")
    }
    
    func getCountryData() async {
        // 본격적으로 CallAPI.swift에서 데이터를 받아와서 모델에 저장하기 위한 코드.
        await getCountryInfo(countries: &self.model.countryList);
        
    }

    func isGotData(_ bool:Bool){
        model.gotData = bool ? 1 : 0
    }

    func isNotGotData() -> Bool {
        if model.gotData == 1 {
            return false
        } else {
            return true
        }
    }

}
