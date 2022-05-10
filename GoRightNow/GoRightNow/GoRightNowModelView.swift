//
//  GoRightNowModelView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/12.
//ß∫

import Foundation

class GoRightNowModelView: ObservableObject {
    @Published var model = GoRightNowModel()
    
    func getCountryData() {
        // 본격적으로 CallAPI.swift에서 데이터를 받아와서 모델에 저장하기 위한 코드.
        DispatchQueue.global(qos: .userInitiated).async {
            getCountryInfo(countries: &self.model.countryList);
        }
    }
}
