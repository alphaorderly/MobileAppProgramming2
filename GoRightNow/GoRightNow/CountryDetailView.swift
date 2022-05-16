//
//  CountryDetailView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/04.
//

import SwiftUI

struct CountryDetailView: View {
    var countryName: String
    var immigInfo: String
    var isoCode: String
    var imgurl: String
    var alarmLevel: Int
    
    var body: some View {
        ZStack{
            ThemeData.background
            VStack {
                Text("")
                    .navigationTitle(countryName)
                ScrollView {
                    FlagImage(iso2: isoCode, url: imgurl)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    AlarmCardView(alarm: alarmLevel)
                    if immigInfo != "" { TextCardView("입국 정보", immigInfo) }
                }
                AppCardView(image: "airplane.departure", url: "https://www.skyscanner.co.kr/transport/flights/kr/\(isoCode)", description: "항공기, 호텔, 렌터카 예약하기")
                    .frame(height: 75)
            }
            .background(.clear)
        }
    }
}

struct flag: View {
    let iso2: String
    
    var body: some View {
        if UIImage(named: iso2) != nil {
            Image(iso2)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Text("국기 없음 \(iso2)")
        }
    }
}

// 각 항목에 대한 카드뷰
struct TextCardView: View {
    var title: String
    var content: String
    
    init(_ title: String, _ content: String) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20).bold())
                Divider()
                Text(content)
            }
            .padding()
        }
        .background(.white.opacity(0.5))
        .cornerRadius(5)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}

struct AlarmCardView : View {
    var alarm: Int
    
    var body: some View {
        HStack {
            Spacer()
            Group {
                switch alarm {
                case 0:
                    Text("특별 여행 주의보 국가")
                case 1:
                    Text("여행 유의 국가")
                case 2:
                    Text("여행 자제 국가")
                case 3:
                    Text("출국 권고 국가")
                case 4:
                    Text("여행 금지 국가")
                default:
                    Text("특별 여행 주의보 국가")
                }
            }
            .padding()
            .font(.system(size: 30).bold())
            Spacer()
        }
        .background(.white.opacity(0.5))
        .cornerRadius(5)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}

// 앱 카드뷰 ( 왼쪽 앱 아이콘 | 오른쪽 클릭버튼 ) -> 누를시 URL 이동!
struct AppCardView : View {
    var image: String
    var url: String
    var description: String
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: image)
            Spacer()
            Divider()
            Spacer()
            Text("\(description)")
            Spacer()
        }
        .background(.white.opacity(0.5))
        .cornerRadius(5)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        .onTapGesture {
            // 사이트 연결
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
