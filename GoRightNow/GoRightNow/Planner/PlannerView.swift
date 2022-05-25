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
    
    @State var addSheet: Bool = false

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
                        ForEach(plannerModelView.model.plans) { data in
                            PlanCard(plan: data)
                                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                                .frame(alignment: .center)
                        }
                        // testPlanList() // 디자인 테스트용 코드
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
            .sheet(isPresented: $addSheet) {
                
            }
        }
    }
}

private struct PlanCard: View {
    var plan: PlannerModel.Plan
    
    var body: some View {
       
        RoundedRectangle(cornerRadius: 5)
            .fill(.white.opacity(0.5))
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 70)
            .overlay(HStack {
                VStack {
                    Text("\(plan.countryName)")
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                .frame(width: UIScreen.main.bounds.width * 0.9 * 0.2, height: 70)
                VStack {
                    Text("\(plan.planName)")
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                .frame(width: UIScreen.main.bounds.width * 0.9 * 0.2, height: 70)
                VStack {
                    Text("\(convertDate(from: plan.departDate))")
                    Text(" ~ \(convertDate(from: plan.returnDate))")
                }
                .frame(width: UIScreen.main.bounds.width * 0.9 * 0.5, height: 70)
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
        RoundedRectangle(cornerRadius: 5)
            .fill(.white.opacity(0.5))
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
            .overlay(HStack {
                    Text("목적지")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width * 0.9 * 0.2, height: 30)
                    Text("여행 목적")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width * 0.9 * 0.2, height: 30)
                    Text("여행 기간")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width * 0.9 * 0.5, height: 30)
            }
                        .frame(height: 30, alignment: .leading)
                     )
    }
}

private struct testPlanList: View { // 디자인 테스트용 리스트 View
    var body: some View {
        VStack {
            PlanCard(plan: PlannerModel.Plan(countryName: "미국", planName: "대충여행", departDate: Date(), returnDate: Date(), places: []))
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .frame(alignment: .center)
            PlanCard(plan: PlannerModel.Plan(countryName: "리히텐슈타인", planName: "테스트 여행", departDate: Date(), returnDate: Date(), places: []))
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .frame(alignment: .center)
            PlanCard(plan: PlannerModel.Plan(countryName: "Testing", planName: "TESTING TRAVEL", departDate: Date(), returnDate: Date(), places: []))
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .frame(alignment: .center)
        }
    }
}
