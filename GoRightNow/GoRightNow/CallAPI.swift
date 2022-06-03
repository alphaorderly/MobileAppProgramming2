//
//  CallAPI.swift
//  PublicAPITest
//
//  Created by 권동영 on 2022/05/01.
//

import Foundation
import Alamofire

struct ArrivalAPIResponse: Codable {
    let data: [searchedCountry]
}

struct AlarmAPIResponse: Codable {
    let data: [searchedAlarm]
}

struct searchedCountry: Codable {
    let country_nm : String
    let txt_origin_cn : String
    let country_iso_alp2: String
}

struct searchedAlarm: Codable {
    let country_nm : String
    let country_iso_alp2: String
    let flag_download_url : String
    let alarm_lvl: Int?
}


func getCountryInfo(countries: inout [GoRightNowModel.Country]) {
    
    // 새로운 값을 받아오기 위한 곳.
    var getCountries: [GoRightNowModel.Country] = []
    
    // 동기화 처리를 위한 세마포어 // 값을 순차적으로 받아옴
    let semaphore = DispatchSemaphore(value: 0)
    let queue     = DispatchQueue.global(qos: .utility)
    
    // 값을 받아올 URL.
    let countryOverseasArrivalsServiceURL = "https://apis.data.go.kr/1262000/CountryOverseasArrivalsService/getCountryOverseasArrivalsList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&numOfRows=200"
    
    let TravelAlarmService2URL = "https://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&pageNo=1&numOfRows=200"
    
    // 데이터 받아오기 (여러개의 데이터를 받아오기 때문에 for문 사용)
    // 순서 : 여행경보 API 호출 -> 코로나 입국정보 API 호출
    // 코로나 입국정보 API를 호출해서, 관련국에 대한 입국정보가 있을 경우 이를 추가
    AF.request(TravelAlarmService2URL, method: .get, encoding: JSONEncoding.default).responseDecodable(of: AlarmAPIResponse.self, queue: queue) { json in
        
        switch json.result {
        case .success:
            if let jsonData = json.value {
                for getData in jsonData.data {
                    getCountries.append(GoRightNowModel.Country(name: getData.country_nm, iso_alp2: getData.country_iso_alp2, immigInfo: "", flagImageURL: getData.flag_download_url, alarmLevel: getData.alarm_lvl ?? 0))
                }
            } else {
                print("TravelAlarmService2 Error");
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
        semaphore.signal()
    }
    
    semaphore.wait()
    
    AF.request(countryOverseasArrivalsServiceURL, method: .get, encoding: JSONEncoding.default).responseDecodable(of: ArrivalAPIResponse.self, queue: queue) { json in
        switch json.result {
        case .success:
            do {
                if let jsonData = json.value {
                    for getData in jsonData.data {
                        var flag = false // 나라가 있었는지 확인하기 - 현재 단계에서는 데이터 테스트용으로 사용
                        for countriesIndice in getCountries.indices {
                            if getCountries[countriesIndice].name == getData.country_nm {
                                getCountries[countriesIndice].immigInfo = getData.txt_origin_cn
                                flag = true
                                break
                            }
                        }
                        if flag == false { // 현재 단계에서는 데이터 테스트 용으로 사용
                            getCountries.append(GoRightNowModel.Country(name: getData.country_nm, iso_alp2: getData.country_iso_alp2, immigInfo: getData.txt_origin_cn, flagImageURL: "", alarmLevel: -1))
                        }
                    }
                } else {
                    print("countryOverseasArrival Error");
                }
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
        semaphore.signal()
    }
    
    // 데이터를 다 받아올때까지 대기함.
    semaphore.wait()
    // 받아온 국가들의 정보를 모델에 적용.
    countries = getCountries
    
    print("Got data")
}

