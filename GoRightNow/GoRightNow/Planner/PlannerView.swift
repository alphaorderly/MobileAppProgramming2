//
//  PlannerView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import SwiftUI

struct PlannerView: View {
    @EnvironmentObject var modelView: GoRightNowModelView;
    @EnvironmentObject var selectView: ViewSelect;
    @EnvironmentObject var plannerModelView: PlannerModelView;

    var body: some View {
        NavigationView {
            ZStack {
                ThemeData.background
                
                VStack {
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
                        Button {
                            // Action
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                        }
                    }
                    VStack {
                        PlanAttr()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                        ForEach(plannerModelView.model.plans) { data in
                            PlanCard(plan: data)
                                // .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                                .frame(alignment: .center)
                        }
                    }
                    Spacer()
                }
                .onAppear {
                    modelView.model.sideMenu = false
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
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true).navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
        }
    }
}

private struct PlanCard: View {
    var plan: PlannerModel.Plan
    
    var body: some View {
       
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 70)
            .overlay(HStack {
                VStack {
                    Text("\(plan.countryName)")
                }
                .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 15)) // 비율 수동 조정됨. 건들지 마시오.
                VStack {
                    Text("\(plan.planName)")
                }
                .padding(EdgeInsets(top: 2, leading: 15, bottom: 2, trailing: 15)) // 비율 수동 조정됨. 건들지 마시오.
                VStack {
                    Text("\(convertDate(from: plan.departDate))")
                    Text(" ~ \(convertDate(from: plan.returnDate))")
                }
                .padding(EdgeInsets(top: 2, leading: 15, bottom: 2, trailing: 5)) // 비율 수동 조정됨. 건들지 마시오.
            }
            .frame(height: 70)
                     )
    }
    
    func convertDate(from curDate : Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: curDate)
    }
}

private struct PlanAttr: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
            .overlay(HStack {
                    Text("목적지")
                        .bold()
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 11)) // 비율 수동 조정됨. 건들지 마시오.
                    Text("여행 목적")
                        .bold()
                        .padding(EdgeInsets(top: 5, leading: 11, bottom: 5, trailing: 27)) // 비율 수동 조정됨. 건들지 마시오.
                    Text("여행 기간")
                        .bold()
                        .padding(EdgeInsets(top: 5, leading: 27, bottom: 5, trailing: 44)) // 비율 수동 조정됨. 건들지 마시오.
            }
                        .frame(height: 30, alignment: .leading)
                     )
    }
}
