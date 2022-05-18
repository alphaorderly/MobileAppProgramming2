//
//  PlannerModel.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import Foundation

struct PlannerModel {
    static var idValue = 0
    
    // 각각의 여행계획에 대한 배열
    var plans: [Plan] = [Plan(countryName: "한국", planName: "종강 여행", departDate: Date(), returnDate: Date(), places: [])]
    
    struct Plan : Identifiable {
        var countryName: String             // 나라 이름
        var planName: String                // 계획 이름
        var departDate: Date                // 출발 일자
        var returnDate: Date                // 도착 일자
        
        var id: Int {
            idValue += 1
            return idValue
        }
        
        var places: [Landmarks]             // 가볼곳들
    }
    
    struct Landmarks {
        var url: String                     // 인터넷 주소
        
        var title: String                   // 표시할 이름
    }
}
