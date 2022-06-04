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
    @Binding var select: ViewList
    var version: String
    var geometry: GeometryProxy
    @State var isShow: Bool = false

    var body: some View {
        HStack {
            VStack {
                Divider()
                Button {
                    select = .planner
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "book.closed.fill")
                        Spacer()
                        Text("Planner")
                    }
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                }
                Divider()
                Button {
                    select = .mainList
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "list.bullet")
                        Spacer()
                        Text("Main")
                    }
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                }
                Divider()
                Button {
                    self.isShow = true
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "gear")
                        Spacer()
                        Text("Setting")
                    }
                            .alert("Version", isPresented: $isShow){
                                Button("Ok"){}
                            } message: {
                                SettingView(version: version)
                            }
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                }
                Divider()
                Spacer()
            }
                    .padding(16)
                    .padding(.top, 100)
                    .background(Color(.systemGray6))
                    .edgesIgnoringSafeArea([.bottom, .top])
                    .shadow(radius: 0)
            Spacer()
        }
                .frame(width: geometry.size.width / 2, height: geometry.size.height)
                .shadow(radius: 5)

    }
}
