//
//  PlannerView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import SwiftUI

struct PlannerView: View {
    
    fileprivate enum Mode {
        case list                       // 일반 모드
        case edit                       // 수정 모드
        case delete                     // 삭제 모드
    }
    
    @EnvironmentObject var modelView: GoRightNowModelView;
    @EnvironmentObject var selectView: ViewSelect;
    @EnvironmentObject var plannerModelView: PlannerModelView;
    
    @State fileprivate var mode: Mode = .list
    @State private var addSheet: Bool = false
    @State private var addAlert: Bool = false

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
                        EditButton(mode: $mode)
                        Spacer()
                        if mode == .list {
                            Button {
                                addSheet = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding()
                            }
                        }
                    }
                    VStack {
                        // 상단바
                        PlanAttr()
                        // 리스트
                        ForEach(plannerModelView.model.plans) { data in
                            PlanCard(plan: data, mode: $mode)
                                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
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
        .sheet(isPresented: $addSheet) {
            AddSheet(dismiss: $addSheet, alert: $addAlert)
        }
    }
}

private struct EditButton: View {
    @Binding var mode : PlannerView.Mode
    
    var body: some View {
        if mode == .list {
            Menu {
                Button {
                    mode = .delete
                } label: {
                    Image(systemName: "minus.circle")
                    Text("삭제하기")
                }
                Button {
                    mode = .edit
                } label: {
                    Image(systemName: "pencil")
                    Text("수정하기")
                }
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                    .padding()
            }
        } else {
            Button {
                mode = .list
            } label: {
                Image(systemName: "return")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                    .padding()
            }
        }
    }
}

private struct AddSheet: View {
    @Binding var dismiss: Bool
    @Binding var alert: Bool
    @EnvironmentObject var plannerModelView: PlannerModelView;
    
    @State var countryName: String = ""
    @State var planName: String = ""
    @State var departDate: Date = Date()
    @State var returnDate: Date = Date()

    
    var body: some View {
            VStack {
                HStack {
                    Button(action: {
                        plannerModelView.addModel(countryName: countryName, planName: planName, departDate: departDate, returnDate: returnDate)
                        dismiss = false
                    }) {
                        Text("추가").bold()
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                    Spacer()
                    Text("추가하기")
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                    Spacer()
                    Button(action: {
                        dismiss = false
                    }) {
                        Text("취소").bold()
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                }
                Form {
                    Section(header: Text("목적지")) {
                        TextField("\(countryName)", text: $countryName)
                    }
                    Section(header: Text("이름")) {
                        TextField("\(planName)", text: $planName)
                    }
                    Section(header: Text("출발일")) {
                        DatePicker(selection: $departDate, label: {})
                            .labelsHidden()
                    }
                    Section(header: Text("도착일")) {
                        DatePicker(selection: $returnDate, label: {})
                            .labelsHidden()
                    }
                }
            }
        }
}

private struct PlanCard: View {
    var plan: PlannerModel.Plan
    @Binding var mode: PlannerView.Mode
    @EnvironmentObject var plannerModelView: PlannerModelView;
    
    @State var deleteAlert = false
    @State var editSheet = false
    
    // 모드별 색상
    var fillColor : Color {
            switch(mode) {
            case .delete:
                return Color.red
            case .edit:
                return Color.blue
            default:
                return Color.white.opacity(0.5)
        }
    }
    
    // 메뉴 클릭시 작동
    var tapGesture: some Gesture {
        switch(mode) {
        case .delete:
            return TapGesture(count: 1)
                .onEnded {
                    deleteAlert = true
                }
        case .edit:
            return TapGesture(count: 1)
                .onEnded {
                    editSheet = true
                }
        default:
            return TapGesture(count: 1)
                .onEnded {
                    
                }
        }
    }
    
    var body: some View {
        if mode != .list {
            RoundedRectangle(cornerRadius: 5)
                .fill(fillColor)
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
                .gesture(tapGesture)
                .transition(.asymmetric(insertion: .identity, removal: .move(edge: .leading)))
                .alert(isPresented: $deleteAlert) {
                    Alert(
                        title: Text("삭제 하시겠습니까?"),
                        message: Text("되돌릴수 없습니다"),
                        primaryButton: .destructive(Text("삭제하기")) {
                            withAnimation {
                                plannerModelView.deleteModel(id: plan.id)
                            }
                        },
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
                .sheet(isPresented: $editSheet) {
                    EditSheet(dismiss: $editSheet, currentPlan: plan)
                }
        } else {
            NavigationLink (
                destination: PlannerDetailView(currentPlan: plan)
            ) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(fillColor)
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
                    .transition(.asymmetric(insertion: .identity, removal: .move(edge: .leading)))
                    .foregroundColor(.black)
                }
            }
        }
    
    
    func convertDate(from curDate : Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: curDate)
    }
}

private struct EditSheet: View {
    @Binding var dismiss: Bool
    @EnvironmentObject var plannerModelView: PlannerModelView;
    var currentPlan: PlannerModel.Plan
    
    @State var countryName: String = ""
    @State var planName: String = ""
    @State var departDate: Date = Date()
    @State var returnDate: Date = Date()

    
    var body: some View {
            VStack {
                HStack {
                    Button(action: {
                        plannerModelView.editModel(countryName: countryName, planName: planName, departDate: departDate, returnDate: returnDate, id: currentPlan.id)
                        dismiss = false
                    }) {
                        Text("수정").bold()
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                    Spacer()
                    Text("수정하기")
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                    Spacer()
                    Button(action: {
                        dismiss = false
                    }) {
                        Text("취소").bold()
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                }
                Form {
                    Section(header: Text("목적지")) {
                        TextField("\(countryName)", text: $countryName)
                    }
                    Section(header: Text("이름")) {
                        TextField("\(planName)", text: $planName)
                    }
                    Section(header: Text("출발일")) {
                        DatePicker(selection: $departDate, label: {})
                            .labelsHidden()
                    }
                    Section(header: Text("도착일")) {
                        DatePicker(selection: $returnDate, label: {})
                            .labelsHidden()
                    }
                }
                .onAppear() {
                    countryName = currentPlan.countryName
                    planName = currentPlan.planName
                    departDate = currentPlan.departDate
                    returnDate = currentPlan.returnDate
                }
        }
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
