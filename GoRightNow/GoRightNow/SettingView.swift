//
//  VersionView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/30.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var modelView: GoRightNowModelView
    @EnvironmentObject var btmshtModelView: BottomSheetModelView
    var fontSize: [CGFloat: String] = [14: "작게", 17: "보통", 20: "크게"] // 입국정보 글씨 크기
    
    var version: String
    
    var body: some View {
        ZStack {
            ThemeData.background
            
            VStack {
                Text("입국정보안내 글씨크기")
                    .font(.system(size: modelView.model.infoFontSize))
                //입국정보 글씨크기 설정을 위한 Picker
                Picker("입국정보안내 글씨크기", selection: $modelView.model.infoFontSize) {
                    ForEach(Array(fontSize.keys).sorted(by: <), id: \.self) {
                        Text(self.fontSize[$0]!)
                    }
                }
                .frame(width: 250)
                .padding()
                .pickerStyle(.segmented)
                .background(Color(.systemGray6))
                .cornerRadius(15)
            }
            
            Spacer()
            
            Text("Current version : \(version)")
                .font(.system(size: 12, weight: .light))
        }
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(version: "Test")
    }
}
