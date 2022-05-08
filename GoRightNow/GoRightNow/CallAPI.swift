//
//  CallAPI.swift
//  PublicAPITest
//
//  Created by 권동영 on 2022/05/01.
//

import Foundation
import Alamofire

func getCountryInfo() -> Country {
    var searchResult : Country
    
    let url = "http://apis.data.go.kr/1262000/CountryKoreaDepartureService"
    
    let test = "https://apis.data.go.kr/1262000/CountryKoreaDepartureService/getCountryKoreaDepartureList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&numOfRows=5&pageNo=1"
    let parameters: Parameters = ["serviceKey": "%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D",
                                    "returnType": "JSON",
                                    "numOfRows": "10",
                                    "pageNo": "1"]
    
    AF.request(test, method: .get).responseJSON { response in
            print("response: \(response)")

        }.resume()
    
    searchResult = demoGetCountryInfo()
    
    return searchResult
}



func testRoutineList() -> String {
    var responseMsg = "success"
    
    let test = "https://www.daegufood.go.kr/kor/api/tasty.html?mode=json&addr=%EC%A4%91%EA%B5%AC"
    
    let test2 = "https://apis.data.go.kr/1262000/CountryKoreaDepartureService/getCountryKoreaDepartureList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&numOfRows=5&pageNo=1"
    
    let url = "http://apis.data.go.kr/1262000/CountryKoreaDepartureService"
    let parameters: [String: Any] = ["serviceKey": "%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D",
                                    "returnType": "JSON",
                                    "numOfRows": "10",
                                    "pageNo": "1"]
    
    AF.request(test2, method: .get).responseJSON { response in
            print("response: \(response)")

        }.resume()
    
//    AF.request(url, method: .get, parameters: parameters).responseJSON { response in
//        print("response: \(response)")
//
//    }.resume()
      return responseMsg
}
