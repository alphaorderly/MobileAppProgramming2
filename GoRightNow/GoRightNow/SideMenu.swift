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

struct SideMenu: View {
    @Binding var menu: Bool
    var version: String
    
    var body: some View {
            HStack {
                    VStack {
                            NavigationLink(
                                destination: SettingView(version: version),
                                label: {
                                    Text("Setting")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                }
                            )
                        Spacer()
                    }
                .padding(16)
                .padding(.top, 100)
                .background(Color(.systemGray6))
                .edgesIgnoringSafeArea([.bottom, .top])
                Spacer()
            }
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            .shadow(radius: 5)
    }
}
