//
//  PlannerDetailView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/25.
//

import SwiftUI
import WebKit


struct PlannerDetailView: View {
    
    fileprivate enum Mode {
        case list
        case delete
    }
    
    
    @EnvironmentObject var plannerModelView: PlannerModelView;
    var currentPlan: PlannerModel.Plan
    
    @State fileprivate var mode: Mode = .list
    
    @State var addSheet = false
    
    
    var body: some View {
        ZStack {
            ThemeData.background
            VStack {
                ScrollView {
                    VStack {
                        ForEach(currentPlan.places, id: \.self) { place in
                            ListItem(currentPlace: place, currentPlan: currentPlan, mode: $mode)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(currentPlan.planName)")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    AddButton(mode: $mode, add: $addSheet)
                }
            }
        }
        .sheet(isPresented: $addSheet) {
            AddWebView(addState: $addSheet, planId: currentPlan.id)
        }
    }
}

private struct AddButton : View {
    @Binding var mode: PlannerDetailView.Mode
    @Binding var add: Bool
    
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
                    add = true
                } label: {
                    Image(systemName: "pencil")
                    Text("추가하기")
                }
            } label: {
                Image(systemName: "square.and.pencil")
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

private struct AddWebView: View{
    @Binding var addState: Bool
    @EnvironmentObject var plannerModelView: PlannerModelView;
    
    var planId: String
    
    @StateObject var webViewStore = WebViewStore()
    
    @State var placeSheet = false
    
    @State var url: URL?
    @State var title: String = ""
    @State var placeSelection: PlannerModel.Place = .Cafe
    
    var body: some View {
        NavigationView {
              WebView(webView: webViewStore.webView)
                .navigationBarItems(trailing: HStack {
                    Button{
                        addState = false
                    } label: {
                        Text("닫기")
                          .imageScale(.large)
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 32, height: 32)
                    }
                  Button{
                      url = webViewStore.url
                      title = ""
                      placeSelection = .Cafe
                      placeSheet = true
                  } label: {
                      Text("추가")
                        .imageScale(.large)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                  }
                  Button(action: goBack) {
                    Image(systemName: "chevron.left")
                      .imageScale(.large)
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 32, height: 32)
                  }.disabled(!webViewStore.canGoBack)
                  Button(action: goForward) {
                    Image(systemName: "chevron.right")
                      .imageScale(.large)
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 32, height: 32)
                  }.disabled(!webViewStore.canGoForward)
                })
                
            }.onAppear {
              self.webViewStore.webView.load(URLRequest(url: URL(string: "https://google.com")!))
            }
            .sheet(isPresented: $placeSheet) {
                HStack {
                    Button(action: {
                        print(planId)
                        plannerModelView.addPlace(id: planId, url: url!, title: title, place: placeSelection)
                        placeSheet = false
                    }) {
                        Text("추가").bold()
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                    Spacer()
                    Text("장소 추가하기")
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                    Spacer()
                    Button(action: {
                        placeSheet = false
                    }) {
                        Text("취소").bold()
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                }
                Form {
                    Section("제목") {
                        TextField("", text: $title)
                    }
                    Picker("장소 설명", selection: $placeSelection) {
                        Text("카페").tag(PlannerModel.Place.Cafe)
                        Text("식당").tag(PlannerModel.Place.Food)
                        Text("명소").tag(PlannerModel.Place.Landmark)
                    }
                    .pickerStyle(.inline)
                }
            }
          }
          
          func goBack() {
            webViewStore.webView.goBack()
          }
          
          func goForward() {
            webViewStore.webView.goForward()
          }
}

private struct ListItem: View {
    @StateObject var webViewStore = WebViewStore()
    
    var currentPlace: PlannerModel.Landmarks
    var currentPlan: PlannerModel.Plan
    
    @Binding var mode: PlannerDetailView.Mode
    
    @EnvironmentObject var plannerModelView: PlannerModelView;
    
    @State var web = false
    
    var body: some View {
        if mode == .list {
            HStack {
                Text("\(currentPlace.title)")
            }
            .onTapGesture {
                web = true
            }
            .sheet(isPresented: $web) {
                NavigationView {
                    WebView(webView: webViewStore.webView)
                      .navigationBarItems(trailing: HStack {
                          Button{
                              web = false
                          } label: {
                              Text("닫기")
                                .imageScale(.large)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                          }
                        Button(action: goBack) {
                          Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                        }.disabled(!webViewStore.canGoBack)
                        Button(action: goForward) {
                          Image(systemName: "chevron.right")
                            .imageScale(.large)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                        }.disabled(!webViewStore.canGoForward)
                      })
                }
              }.onAppear {
                  self.webViewStore.webView.load(URLRequest(url: URL(string: "\(currentPlace.url)")!))
              }
        } else {
            HStack {
                Text("\(currentPlace.title)")
                    .foregroundColor(.red)
            }
            .onTapGesture {
                plannerModelView.deletePlace(id: currentPlan.id, place: currentPlace)
            }
        }
        
        }

    func goBack() {
      webViewStore.webView.goBack()
    }

    func goForward() {
      webViewStore.webView.goForward()
    }
}
