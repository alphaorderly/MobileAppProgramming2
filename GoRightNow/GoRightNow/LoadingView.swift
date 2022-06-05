//
//  LoadingView.swift
//  GoRightNow
//
//  Created by 김범준 on 2022/06/03.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("COVID-19")
                .foregroundColor(.red)
                .font(.system(size: 20, weight: .bold, design: .default))
            Text("입국정보안내")
                .font(.system(size: 20, weight: .bold, design: .default))
            Spacer()

            Image("LoadingIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250, alignment: .center)
    
            Spacer()
            Spacer()
            Spacer()
            ProgressView()
            Text("입국정보 데이터 받아오는 중")
                .font(.system(size: 12))
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
