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
    
    var body: some View {
            HStack {
                    VStack {
                        Divider()
                        Button {
                            select = .planner
                        } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Image(systemName: "book.closed.fill")
                                    Spacer()
                                    Text("Planner")
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                        Divider()
                        Button {
                            select = .mainList
                        } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Image(systemName: "list.bullet")
                                    Spacer()
                                    Text("Main")
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                        Divider()
                        NavigationLink(
                            destination: SettingView(version: version),
                            label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Image(systemName: "gear")
                                    Spacer()
                                    Text("Setting")
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                            }
                        )
                        Divider()
                        Spacer()
                    }
                .padding(16)
                .padding(.top, 100)
                .background(Color(.systemGray6))
                .edgesIgnoringSafeArea([.bottom, .top])
                .shadow(radius:0)
                Spacer()
            }
            .frame(width: geometry.size.width/2, height: geometry.size.height)
            .shadow(radius: 5)
    }
}
