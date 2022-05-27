//
//  GoRightNowModelView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/12.
//ß∫

import Foundation

class GoRightNowModelView: ObservableObject {
    @Published var model = GoRightNowModel()
    
    func getCountryData() async {
        // 본격적으로 CallAPI.swift에서 데이터를 받아와서 모델에 저장하기 위한 코드.
        await getCountryInfo(countries: &self.model.countryList);
        
    }

    func getCountryLocation() async  {
         await self.model.countries = getCountryLocationInfo(countries: self.model.countries)
    }

}
