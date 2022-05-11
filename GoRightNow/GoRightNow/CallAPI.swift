//
//  CallAPI.swift
//  PublicAPITest
//
//  Created by 권동영 on 2022/05/01.
//

import Foundation
import Alamofire

struct APIResponse: Codable {
    let data: [searchedCountry]
}

struct searchedCountry: Codable {
    let country_nm : String
    let txt_origin_cn : String
    let country_iso_alp2: String
}

func getCountryInfo(countries: inout [GoRightNowModel.Country]) {
    
    // 새로운 값을 받아오기 위한 곳.
    var getCountries: [GoRightNowModel.Country] = []
    
    // 동기화 처리를 위한 세마포어 // 값을 순차적으로 받아옴
    let semaphore = DispatchSemaphore(value: 0)
    let queue     = DispatchQueue.global(qos: .utility)
    
    // 값을 받아올 URL.
    let countryOverseasArrivalsServiceURL = "https://apis.data.go.kr/1262000/CountryOverseasArrivalsService/getCountryOverseasArrivalsList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&perPage=200"
    
    let countryKoreaDepartureServiceURL = "https://apis.data.go.kr/1262000/CountryKoreaDepartureService/getCountryKoreaDepartureList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&perPage=200"
    
    // 데이터 받아오기 ( 여러개의 데이터를 받아오기 때문에 for문 사용함 
    AF.request(countryOverseasArrivalsServiceURL, method: .get, encoding: JSONEncoding.default).responseDecodable(of:APIResponse.self, queue: queue) { json in
        switch json.result {
        case .success:
            if let jsonData = json.value {
                for getData in jsonData.data {
                    getCountries.append(GoRightNowModel.Country(name: getData.country_nm, iso_alp2: getData.country_iso_alp2, immigInfo: getData.txt_origin_cn, immigInfoForKor: ""))
                }
            } else {
                print("countryOverseasArrival Error");
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
        semaphore.signal()
    }
    
    semaphore.wait()
    AF.request(countryKoreaDepartureServiceURL, method: .get, encoding: JSONEncoding.default).responseDecodable(of:APIResponse.self, queue: queue) { json in
        switch json.result {
        case .success:
            do {
                if let jsonData = json.value {
                    for getData in jsonData.data {
                        for countriesIndice in getCountries.indices {
                            if getCountries[countriesIndice].name == getData.country_nm {
                                getCountries[countriesIndice].immigInfoForKor = getData.txt_origin_cn
                            }
                        }
                    }
                } else {
                    print("countryKoreaDepart Error");
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


/*
 
func test_getCountryInfo(of country: String) -> String {
    var searchName = ""
    var searchInfo = ""
    var searchInfoKor = "none"

    var encodedString = country.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    let countryOverseasArrivalsServiceURL = "https://apis.data.go.kr/1262000/CountryOverseasArrivalsService/getCountryOverseasArrivalsList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&numOfRows=5&pageNo=1&cond[country_nm::EQ]=\(encodedString)"
    
    let countryKoreaDepartureServiceURL = "https://apis.data.go.kr/1262000/CountryKoreaDepartureService/getCountryKoreaDepartureList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&numOfRows=5&pageNo=1&cond[country_nm::EQ]=\(encodedString)"
    
    AF.request(countryOverseasArrivalsServiceURL, method: .get, encoding: JSONEncoding.default).responseJSON { response in
        switch response.result {
        case .success(let res):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                let json = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                print("\(json.data[0].country_nm)")
                print("\(json.data[0].txt_origin_cn)")
                searchName = json.data[0].country_nm
                searchInfo = json.data[0].txt_origin_cn
            } catch (let err) {
                print(err.localizedDescription)
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
    
    AF.request(countryKoreaDepartureServiceURL, method: .get, encoding: JSONEncoding.default).responseJSON { response in
        switch response.result {
        case .success(let res):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                let json = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                if !(json.data.isEmpty) {
                    print("\(json.data[0].country_nm)")
                    print("\(json.data[0].txt_origin_cn)")
                    searchInfoKor = json.data[0].txt_origin_cn
                } else {
                    print("no txt_origin_cn")
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
    
    let searchResult = GoRightNowModel.Country(name: searchName, immigInfo: searchInfo, immigInfoForKor: searchInfoKor)
    // searchResult = demoGetCountryInfo()
    
    return country
}
 
*/
