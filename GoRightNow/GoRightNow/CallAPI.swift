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
}

func getCountryInfo(countries: inout [GoRightNowModel.Country]) {
    
    // 새로운 값을 받아오기 위한 곳.
    var getCountries: [GoRightNowModel.Country] = []
    
    // 값을 받아올 URL.
    let countryOverseasArrivalsServiceURL = "https://apis.data.go.kr/1262000/CountryOverseasArrivalsService/getCountryOverseasArrivalsList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&numOfRows=5&pageNo=1"
    
    let countryKoreaDepartureServiceURL = "https://apis.data.go.kr/1262000/CountryKoreaDepartureService/getCountryKoreaDepartureList?serviceKey=%2BnLU6YmF24aLEOo7V0yqqvuPb6a4jaNXPVyGqFmMbJhKzpzTaGIQZXTI35srP9jSb%2BD15D%2Fhf9CD85%2BT%2FdAwOw%3D%3D&returnType=JSON&numOfRows=5&pageNo=1"
    
    // 데이터 받아오기 ( 여러개의 데이터를 받아오기 때문에 for문 사용함
    AF.request(countryOverseasArrivalsServiceURL, method: .get, encoding: JSONEncoding.default).responseJSON { response in
        switch response.result {
        case .success(let res):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                let json = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                for getData in json.data {
                    print("\(getData.country_nm)")
                    print("\(getData.txt_origin_cn)")
                    getCountries.append(GoRightNowModel.Country(name: getData.country_nm, immigInfo: getData.txt_origin_cn, immigInfoForKor: ""))
                }
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
                for getData in json.data {
                    for countriesIndice in getCountries.indices {
                        if getCountries[countriesIndice].name == getData.country_nm {
                            print(getData.txt_origin_cn)
                            getCountries[countriesIndice].immigInfoForKor = getData.txt_origin_cn
                        }
                    }
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
    
    // 받아온 국가들의 정보를 모델에 적용시키는 과정
    countries = getCountries
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
