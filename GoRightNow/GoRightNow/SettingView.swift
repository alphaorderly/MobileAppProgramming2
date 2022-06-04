//
//  VersionView.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/30.
//

import SwiftUI
import BottomSheetSwiftUI

struct SettingView: View {
    @EnvironmentObject var modelView: GoRightNowModelView
    @EnvironmentObject var btmshtModelView: BottomSheetModelView
    @EnvironmentObject var selectView: ViewSelect;
    var fontSize: [CGFloat: String] = [14: "작게", 17: "보통", 21: "크게"] // 입국정보 글씨 크기
    let btmSheetPos: [BottomSheetPosition: String] = [.bottom: "하단", .middle: "중단", .top: "상단"]
    
    var version: String
    
    var body: some View {
        ZStack {
            ThemeData.background
            VStack {
                ZStack {
                    HStack {
                        Button {
                            withAnimation {
                                modelView.model.sideMenu = !modelView.model.sideMenu
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                        }
                        Spacer()
                    }
                    VStack {
                        Text("기본 설정")
                            .font(.system(size: 22, weight: .bold))
                    }
                }
                VStack {
                    Spacer().frame(height: 30)
                    VStack {
                        Text("입국정보안내 글씨크기")
                            .font(.system(size: modelView.model.infoFontSize))
                            .frame(height: 30)
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
                    Spacer().frame(height: 50)
                    VStack {
                        Text("국가 리스트 위치")
                        Picker("국가 리스트 위치", selection: $btmshtModelView.model.bottomSheetPosition) {
                            ForEach(Array(btmSheetPos.keys).sorted(by: sheetPosSort), id: \.self) {
                                Text(self.btmSheetPos[$0]!)
                            }
                        }
                        .frame(width: 250)
                        .padding()
                        .pickerStyle(.segmented)
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                    }
                }
                
                Spacer()
                
                Text("Current version : \(version)")
                    .font(.system(size: 14, weight: .light))
            }
            .onAppear {
                modelView.model.sideMenu = false
                btmshtModelView.toggleSettingMode()
            }
            .onDisappear() {
                btmshtModelView.toggleSettingMode()
            }
            
            if modelView.model.sideMenu {
                GeometryReader { geometry in
                    HStack (spacing: 0){
                        SideMenu(menu: $modelView.model.sideMenu, select: $selectView.selectedView, version: modelView.model.version, geometry: geometry)
                        Color.init(red: 0, green: 0, blue: 0, opacity: 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // 사이드바 다시 집어 넣기 위한 코드
                                withAnimation {
                                    modelView.model.sideMenu = false
                                    print(modelView.model.sideMenu)
                            }
                        }
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)).animation(.linear(duration: 0.2)))
                .zIndex(100)
                // Animation 구현 및 Sidebar가 절대로 뒤에 가지 않도록 설정
            }
        }
    }
}

func sheetPosSort(lhs: BottomSheetPosition, rhs: BottomSheetPosition) -> Bool {
    if lhs == .bottom {
        return true
    } else if lhs == .middle {
        switch rhs {
        case .bottom:
            return false
        case .top:
            return true
        default:
            return false
        }
    } else {
        return false
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(version: "Test")
    }
}
