//
// Created by jeonggyunyun on 2022/05/22.
//

import Foundation
import MapKit
import MapboxGeocoder

//import Combine

let geocoder = Geocoder(accessToken: "pk.eyJ1IjoiYWJjZG9ncyIsImEiOiJjbDNvbmNsMHUwcTB0M2VwN2kxeGhxenN6In0.5eJc0CDhFS8_p9hFEOwm5w")


@MainActor
func getCountryLocationInfo(countries: [GoRightNowModel.Country]) async -> [GoRightNowModel.Country] {
    var newCountries: [GoRightNowModel.Country] = []

    for index in countries.indices {
        var country = countries[index]
//        let response = await getSearchResponse(text: country.name)?.mapItems.first?.placemark.coordinate
        var response = await getSearchResponse(text: country.iso_alp2)?.location?.coordinate
//        if response == nil {
//            print("[MapKit]Searing\(country.name)")
//            response = await getSearchResponse(text: country.iso_alp2)?.mapItems.first?.placemark.coordinate
//        } else {
//            print("[CLGeocoder]Searing\(country.name)")
//        }
        guard let response = response else {
            print("No Found \(country.name)")
            continue
        }
        print("Found \(country.name)")
        await newCountries.append(GoRightNowModel.Country(
                name: country.name,
                iso_alp2: country.iso_alp2, immigInfo: country.immigInfo,
                flagImageURL: country.flagImageURL,
                alarmLevel: country.alarmLevel,
                location: Location(title: country.name, latitude: response.latitude, longitude: response.longitude)))
    }
    return newCountries
}

func helloFunction(_ str: String) async {
    let hell = CLGeocoder()
    var string: [CLPlacemark] = try! await hell.geocodeAddressString(str)
    let kkkk = string.first?.location?.coordinate
    print("lat: \(kkkk?.latitude)  lon: \(kkkk?.longitude)")

}

func helloFunction2(_ str: String) {
    let options = ForwardGeocodeOptions(query: str)
    options.allowedScopes = [.country]
    geocoder.geocode(options) { placemarks, attribution, error in
        guard let coordinate = placemarks?.first?.location?.coordinate else {
            print("No Founded")
            return
        }
        print("\(str) location is \(coordinate)")
    }

}


func isAllSearchingDone(countries: [GoRightNowModel.Country], completion: @escaping (Bool, [GoRightNowModel.Country]) -> Void) {
    print("Start All Searching")
    var newCountries: [GoRightNowModel.Country] = []
    for country in countries {
        isSearchingDone(country: country) { done, country in
            if (done) {
                print("\(country.name) Searching Done")
                newCountries.append(country)
                if(countries.last?.name == country.name){
                    print("All Searching Done")
                    completion(true, newCountries)
                }
            } else {
                print("Nope")
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
                }
            }
            return
        }
        newCountry.location = Location(title: country.name, latitude: coordinate.latitude, longitude: coordinate.longitude)
        completion(true, newCountry)
    }
}


func helloFunction3(modelView: GoRightNowModelView, mapModelView: MapModelView){
    print("Start View Change")
    isAllSearchingDone(countries: modelView.model.countries) { isSuccess, countries in
        if (isSuccess) {
            modelView.model.countries = countries
            mapModelView.makePin(countries: countries)
            modelView.model.gotData = 1
            print("Changes")
        }
    }

}

func getSearchResponse(text: String) async -> CLPlacemark? {
    let geocoder = CLGeocoder()
    let gecInfo: CLPlacemark? = try? await geocoder.geocodeAddressString(text).first
    return gecInfo
}

@MainActor
func getSearchResponse(text: String) async -> MKLocalSearch.Response? {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = countryNameHandler(text)
    let search = MKLocalSearch(request: searchRequest)
    let start: MKLocalSearch.Response? = try? await search.start()
//    print(start.mapItems.first?.placemark.coordinate.latitude)
    return start
}

func searchingToLocalSearch(_ country: GoRightNowModel.Country,completion: @escaping (Bool, Location) -> Void) {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = countryNameHandler(country.name)
    let search = MKLocalSearch(request: searchRequest)
    search.start { response, error in
        guard let response=response?.mapItems.first?.placemark.coordinate else {
            print("[MK Search] \(country.name) No Found")
            return
        }
        let location = Location(title: country.name, latitude: response.latitude, longitude: response.longitude)
        completion(true, location)
    }
}

func countryNameHandler(_ text: String) -> String {
    var result = ""
//    print("\(text)")

    switch text {
    case "도미니카공화국": result = "도미니카 공화국" // 띄어쓰기 이슈
    case "마셜제도": result = "마주로" // 애플지도에 마셜 제도가 제대로 검색되지 않아 마셜 제도의 수도로 설정
    case "마이크로네시아연방": result = "미크로네시아" // 외래어 표기법 이슈
    case "모리타니아": result = "" // 해결 불가. 원인을 알 수 없음

    default: result = text
    }

    return result
}
