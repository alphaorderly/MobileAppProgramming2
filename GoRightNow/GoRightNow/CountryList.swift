//
//  CountryList.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/02.
//

import SwiftUI

struct CountryList: View {
    @EnvironmentObject var mapModelView: MapModelView
    @EnvironmentObject var bottomSheetModelView: BottomSheetModelView;
    var countries: [GoRightNowModel.Country]
    //Tap한 값을 Modal에 넘겨주기 위한 Property
    @State private var showModal: Bool = false
    @State private var name: String = " "
    @State private var immg: String = " "
    @State private var imgurl: String  = " "
    @State private var isocode: String = " "
    @State private var alarm: Int = 0


    var body: some View {
        ForEach(countries, id: \.self) { data in
            ListTile(name: data.name, immg: data.immigInfo, imgurl: data.flagImageURL, isocode: data.iso_alp2, alarm: data.alarmLevel)
                    .onTapGesture {
//                        self.showModal = true
//                        self.name = data.name
//                        self.immg = data.immigInfo
//                        self.imgurl = data.flagImageURL
//                        self.isocode = data.iso_alp2
//                        self.alarm = data.alarmLevel
                        print("Log: Touched Country Name is \(data.name)")
                        print("Log: Touched Country Name is \(data.location)")
                        //TODO nill 처리 필요
                        mapModelView.model.mapView.setRegion(data.location!.region, animated: true)
//                        mapModelView.clearAnnotations()
                        mapModelView.makePin(location: data.location!)
//                        mapModelView.setAnnotations()
                        bottomSheetModelView.position = .bottom
                    }
//                    .sheet(isPresented: $showModal) {
//                        CountryDetailView(countryName: self.name, immigInfo: self.immg, isoCode: self.isocode, imgurl: self.imgurl, alarmLevel: self.alarm)
//                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

private struct ListTile: View {
    var name: String
    var immg: String
    var imgurl: String
    var isocode: String
    var alarm: Int

    var body: some View {

        HStack {
            FlagImage(iso2: isocode, url: imgurl)
                    .frame(width: 80, height: 53)
                    .cornerRadius(5)
                    .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 0))
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                Text(name)
                Spacer()
                VStack {
                    Group {
                        switch alarm {
                        case 0:
                            Circle()
                                    .foregroundColor(.init(uiColor: UIColor(red: 53 / 255, green: 80 / 255, blue: 121 / 255, alpha: 1.0)))
                        case 1:
                            Circle()
                                    .foregroundColor(.init(uiColor: UIColor(red: 244 / 255, green: 196 / 255, blue: 88 / 255, alpha: 1.0)))
                        case 2:
                            Circle()
                                    .foregroundColor(.init(uiColor: UIColor(red: 184 / 255, green: 54 / 255, blue: 36 / 255, alpha: 1.0)))
                        case 3:
                            Circle()
                                    .foregroundColor(.init(uiColor: UIColor(red: 41 / 255, green: 41 / 255, blue: 41 / 255, alpha: 1.0)))
                        case 4:
                            Circle()
                                    .foregroundColor(.init(uiColor: UIColor(red: 184 / 255, green: 54 / 255, blue: 36 / 255, alpha: 1.0)))
                        default:
                            Circle()
                        }
                    }
                            .frame(minWidth: 20, idealWidth: 20, maxWidth: 20, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .trailing)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
            }
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
        }
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .shadow(radius: 5)
                .opacity(0.8)
    }
}

private struct FlagImage: View {
    let iso2: String
    let url: String

    var body: some View {
        if UIImage(named: iso2) != nil {
            Image(iso2)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
        } else {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                    .aspectRatio(contentMode: .fit)
        }
    }
}
