//
//  GoRightNowModel.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/12.
//

import Foundation
import SwiftUI


struct GoRightNowModel {
    var textInput: String = ""

    var sideMenu: Bool = false                   // 사이드 메뉴상태

    let version: String = "1.0.0"                // 설정 버전 표시용

    var countries: [Country] = []               // 국가들을 받아올 배열.
    
    var countryList: [Country] {                // 검색 알고리즘
        get {
            countries.filter {
                if textInput == "" {
                    return true
                } else {
                    return Jamo.getJamo($0.name).contains(Jamo.getJamo(textInput))
                }
            }
        } set {
            countries = newValue
        }
    }
    
    var gotData = 0                             // 데이터 받아왔는지 검사하기

    struct Country: Hashable {
        var name : String                   // 국가명
        var iso_alp2 : String               // ISO 국가 코드명
        var immigInfo : String              // 입국정보, immigration Info
        var flagImageURL : String           // 국기 이미지 URL
        var alarmLevel : Int
        // 여행경보 정보, 바티칸 등 일부 국가는 nil이면 0
        var location: Location?
    }
}
