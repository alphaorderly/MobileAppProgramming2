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
    searchRequest.naturalLanguageQuery = text
    let search = MKLocalSearch(request: searchRequest)
    let start: MKLocalSearch.Response = try! await search.start()
//    print(start.mapItems.first?.placemark.coordinate.latitude)
    return start

}