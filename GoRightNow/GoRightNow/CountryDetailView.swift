//
//  CountryDetailView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/04.
//

import SwiftUI

struct CountryDetailView: View {
    @EnvironmentObject var modelView: GoRightNowModelView
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
                    if immigInfo != "" { TextCardView("입국 정보", immigInfo, modelView.model.infoFontSize) }
                }
                AppCardView(image: "airplane.departure", url: "https://www.skyscanner.co.kr/transport/flights/kr/\(isoCode)", description: "항공기, 호텔, 렌터카 예약하기")
                    .frame(height: 75)
            }
            .background(.clear)
        }
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


// 각 항목에 대한 카드뷰
private struct TextCardView: View {
    var title: String
    var content: String
    var contentFontSize: CGFloat
    
    init(_ title: String, _ content: String, _ contentFontSize: CGFloat) {
        self.title = title
        self.content = content
        self.contentFontSize = contentFontSize
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20).bold())
                Divider()
                let contentForView = content.replacingOccurrences(of: "\n", with: "\n\n") //immginfo 줄바꿈시 한칸 더 띄움
                Text(contentForView)
                    .font(.system(size: contentFontSize))
            }
            .padding()
        }
        .background(.white.opacity(0.5))
        .cornerRadius(5)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}

private struct AlarmCardView : View {
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
                        //.foregroundColor(.init(uiColor: UIColor(red: 184/255, green: 54/255, blue: 36/255, alpha: 1.0)))
                case 3:
                    Text("출국 권고 국가")
                case 4:
                    Text("여행 금지 국가")
                        //.foregroundColor(.init(uiColor: UIColor(red: 184/255, green: 54/255, blue: 36/255, alpha: 1.0)))
                default:
                    Text("특별 여행 주의보 국가")
                }
            }
            .padding()
            .font(.system(size: 30).bold())
            Spacer()
        }
        .background(color().opacity(0.3))
        .cornerRadius(5)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
    
    private func color() -> Color { // 여행경보 배경 사각형 테두리 색상 변경
        var result = Color.white
        
        switch alarm {
        case 0:
            result = Color(red: 53 / 255, green: 80 / 255, blue: 121 / 255)
        case 1:
            result = Color(red: 244 / 255, green: 196 / 255, blue: 88 / 255)
        case 2:
            result = Color(red: 184 / 255, green: 54 / 255, blue: 36 / 255)
        case 3:
            result = Color(red: 41 / 255, green: 41 / 255, blue: 41 / 255)
        case 4:
            result = Color(red: 184 / 255, green: 54 / 255, blue: 36 / 255)
        default:
            result = Color.white
        }
        
        return result
    }
}

// 앱 카드뷰 ( 왼쪽 앱 아이콘 | 오른쪽 클릭버튼 ) -> 누를시 URL 이동!
private struct AppCardView : View {
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

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(countryName: "TEST", immigInfo: "TEST", isoCode: "TEST", imgurl: "", alarmLevel: 1)
        CountryDetailView(countryName: "TEST", immigInfo: "TEST", isoCode: "TEST", imgurl: "", alarmLevel: 2)
        CountryDetailView(countryName: "TEST", immigInfo: "TEST", isoCode: "TEST", imgurl: "", alarmLevel: 3)
        CountryDetailView(countryName: "TEST", immigInfo: "TEST", isoCode: "TEST", imgurl: "", alarmLevel: 4)
        CountryDetailView(countryName: "TEST", immigInfo: "TEST", isoCode: "TEST", imgurl: "", alarmLevel: 0)
    }
}
