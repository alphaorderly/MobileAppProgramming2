//
//  SideMenu.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/11.
//

import SwiftUI

/*
 
    사이드 메뉴
 
 */

struct SideMenu: View, Animatable {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Setting")
                    .font(.title)
                
                Spacer()
            }
            .padding(16)
            .padding(.top, 50)
            .background(Color(.systemGray6))
            .edgesIgnoringSafeArea([.bottom, .top])
            Spacer()
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
