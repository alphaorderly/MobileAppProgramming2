//
//  PlannerModel.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import Foundation

struct PlannerModel {
    // 각각의 여행계획에 대한 배열
    var plans: [Plan] = []
    
    struct Plan {
        var countryName: String             // 나라 이름
        var planName: String                // 계획 이름
        var departData: Date                // 출발 일자
        var returnData: Date                // 도착 일자
        
        var places: [Landmarks]             // 가볼곳들
    }
    
    struct Landmarks {
        var url: String                     // 인터넷 주소
        
        var title: String                   // 표시할 이름
    }
}
