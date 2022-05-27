//
// Created by jeonggyunyun on 2022/05/22.
//

import Foundation
import MapKit

//import Combine

//@EnvironmentObject var modelView: GoRightNowModelView;


let searchRequest = MKLocalSearch.Request()


func getCountryLocationInfo(countries: [GoRightNowModel.Country]) async -> [GoRightNowModel.Country] {
    var newCountries: [GoRightNowModel.Country] = []

    for index in countries.indices {
        var country = countries[index]
        let response = await getSearchResponse(text: country.name).mapItems.first?.placemark.coordinate
        await newCountries.append(GoRightNowModel.Country(
                name: country.name,
                iso_alp2: country.iso_alp2, immigInfo: country.immigInfo,
                flagImageURL: country.flagImageURL,
                alarmLevel: country.alarmLevel,
                location: Location(title: country.name, latitude: response!.latitude, longitude: response!.longitude)))
    }

    return newCountries
}

func getSearchResponse(text: String) async -> MKLocalSearch.Response {
    searchRequest.naturalLanguageQuery = countryNameHandler(text)
    let search = MKLocalSearch(request: searchRequest)
    let start: MKLocalSearch.Response = try! await search.start()
//    print(start.mapItems.first?.placemark.coordinate.latitude)
    return start

}

func countryNameHandler(_ text : String) -> String {
    var result = ""
    print("\(text)")
    
    switch text {
    case "도미니카공화국": result = "도미니카 공화국" // 띄어쓰기 이슈
    case "마셜제도": result = "마주로" // 애플지도에 마셜 제도가 제대로 검색되지 않아 마셜 제도의 수도로 설정
    case "마이크로네시아연방": result = "미크로네시아" // 외래어 표기법 이슈
    case "모리타니아": result = "" // 해결 불가. 원인을 알 수 없음
        
    default: result = text
    }
    
    return result
}
