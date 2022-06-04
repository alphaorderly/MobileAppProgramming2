//
//  PlannerModel.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import Foundation



struct PlannerModel: Codable {
    
    enum Place: Codable {
        case Landmark
        case Food
        case Cafe
        // etc
    }
        
    // 각각의 여행계획에 대한 배열
    var plans: [Plan] = [Plan(countryName: "한국", planName: "종강 여행", departDate: Date(), returnDate: Date(), places: [])]
    
    struct Plan : Identifiable, Codable {
        var countryName: String             // 나라 이름
        var planName: String                // 계획 이름
        var departDate: Date                // 출발 일자
        var returnDate: Date                // 도착 일자
        
        var id: String {
            countryName + planName + departDate.description + returnDate.description
        }
        
        var places: [Landmarks]             // 가볼곳들
    }
    
    struct Landmarks: Hashable, Equatable, Codable {
        var url: URL                     // 인터넷 주소
        var title: String                   // 표시할 이름
        var place: Place                    // 장소에 대한 간단한 설명
    }
    
    mutating func edit(countryName: String, planName: String, departDate: Date, returnDate: Date, id: String) {
        for index in plans.indices {
            if plans[index].id == id {
                plans[index].countryName = countryName
                plans[index].planName = planName
                plans[index].departDate = departDate
                plans[index].returnDate = returnDate
            }
        }
    }
    
    mutating func add(countryName: String, planName: String, departDate: Date, returnDate: Date) {
        let plan = Plan(countryName: countryName, planName: planName, departDate: departDate, returnDate: returnDate, places: [])
        if plans.filter({ $0.id == plan.id }).count == 0 {
            plans.append(plan)
        }
    }
    
    mutating func addPlace(id: String, url: URL, title: String, place: PlannerModel.Place) {
        for p in plans.indices {
            if plans[p].id == id {
                plans[p].places.append(Landmarks(url: url, title: title, place: place))
                break
            }
        }
    }
    
    mutating func deletePlace(id: String, place: PlannerModel.Landmarks) {
        for p in plans.indices {
            if plans[p].id == id {
                for pl in plans[p].places.indices {
                    if plans[p].places[pl] == place {
                        plans[p].places.remove(at: pl)
                    }
                }
            }
        }
    }
    // Document에 데이터 저장하기 위한 메서드 & initializer
    func json() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(PlannerModel.self, from: json)
    }
    
    init(url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try PlannerModel(json: data)
    }
    
    init() { }
}
