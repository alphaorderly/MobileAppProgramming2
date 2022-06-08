//
// Created by jeonggyunyun on 2022/05/22.
//

import Foundation
import MapKit
import MapboxGeocoder

let geocoder = Geocoder.shared

func isAllSearchingDone(countries: [GoRightNowModel.Country], completion: @escaping (Bool, [GoRightNowModel.Country]) -> Void) {
    print("Start All Searching")
    var newCountries: [GoRightNowModel.Country] = []
    var searchedCount = 0;
    var maxCount = countries.count
    for country in countries {
        isSearchingDone(country: country) { isResult, country in
            if (isResult) {
                print("\(country.name) Searching Done")
                searchedCount += 1
                newCountries.append(country)
                if(maxCount == searchedCount){
                    print("All Searching Done")
                    completion(true, newCountries)
                }
            } else {
                searchedCount += 1
                print("[All]Cannot Found \(country.name)")
            }
        }
    }
}

func isSearchingDone(country: GoRightNowModel.Country, completion: @escaping (Bool, GoRightNowModel.Country) -> Void) {
    let options = ForwardGeocodeOptions(query: country.iso_alp2)
    var newCountry: GoRightNowModel.Country = country
    options.allowedISOCountryCodes = [country.iso_alp2]
    options.allowedScopes = [.country]
    geocoder.geocode(options) { (placemarks, attribution, error) in
        guard let coordinate = placemarks?.first?.location?.coordinate else {
            print("[MapBox] \(country.name) No Found")
            searchingToLocalSearch(country) { b, location in
                if (b) {
                    newCountry.location = location
                    completion(true, newCountry)
                } else {
                    completion(false, newCountry)
                }
            }
            return
        }
        newCountry.location = Location(title: country.name, latitude: coordinate.latitude, longitude: coordinate.longitude)
        completion(true, newCountry)
    }
}


func getLocationInfoAndMakeLocationPin(modelView: GoRightNowModelView, mapModelView: MapModelView, completion: @escaping () -> ()){
    isAllSearchingDone(countries: modelView.model.countries) { isSuccess, countries in
        if (isSuccess) {
            modelView.model.countries = countries
            mapModelView.makePin(countries: countries)
            completion()
        }
    }

}

func getSearchResponse(text: String) async -> CLPlacemark? {
    let geocoder = CLGeocoder()
    let gecInfo: CLPlacemark? = try? await geocoder.geocodeAddressString(text).first
    return gecInfo
}


func searchingToLocalSearch(_ country: GoRightNowModel.Country,completion: @escaping (Bool, Location?) -> Void) {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = countryNameHandler(country.name)
    let search = MKLocalSearch(request: searchRequest)
    search.start { response, error in
        guard let response=response?.mapItems.first?.placemark.coordinate else {
            print("[MK Search] \(country.name) No Found")
            completion(false, nil)
            return
        }
        let location = Location(title: country.name, latitude: response.latitude, longitude: response.longitude)
        completion(true, location)
    }
}

func countryNameHandler(_ text: String) -> String {
    var result: String!

    switch text {
    case "도미니카공화국": result = "도미니카 공화국" // 띄어쓰기 이슈
    case "마셜제도": result = "마주로" // 애플지도에 마셜 제도가 제대로 검색되지 않아 마셜 제도의 수도로 설정
    case "마이크로네시아연방": result = "미크로네시아" // 외래어 표기법 이슈

    default: result = text
    }

    return result
}
