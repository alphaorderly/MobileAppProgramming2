//
//  PlannerModelView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import Foundation

class PlannerModelView: ObservableObject {
    @Published var model: PlannerModel {
        didSet {
            save() //여기서 데이터 저장
        }
    }
    
    func deleteModel(id: String) {
        model.plans.removeAll {
            $0.id == id
        }
    }
    
    func editModel(countryName: String, planName: String, departDate: Date, returnDate: Date, id: String) {
        model.edit(countryName: countryName, planName: planName, departDate: departDate, returnDate: returnDate, id: id)
    }
    
    func addModel(countryName: String, planName: String, departDate: Date, returnDate: Date) {
        model.add(countryName: countryName, planName: planName, departDate: departDate, returnDate: returnDate)
    }
    
    func addPlace(id: String, url: URL, title: String, place: PlannerModel.Place) {
        model.addPlace(id: id, url: url, title: title, place: place)
    }
    
    func deletePlace(id: String, place: PlannerModel.Landmarks) {
        model.deletePlace(id: id, place: place)
    }
    // 사용자 Document 경로
    private struct PlannerChanged {
        static let filename = "Saved.planner"
        static var url: URL? {
            let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return docDirectory?.appendingPathComponent(filename)
        }
    }
    // 플래너 데이터를 저장하기 위한 메서드
    private func save() {
        let thisFunction = "\(String(describing: self)).\(#function)"
        if let url = PlannerChanged.url {
            do {
                let data: Data = try model.json()
                print("\(thisFunction) json = \(String(data: data, encoding: .utf8) ?? "nil")")
                try data.write(to: url)
                print("\(thisFunction) success!")
            } catch let encodingError where encodingError is EncodingError {
                print("\(thisFunction) couldn't encode Planner as JSON because\(encodingError.localizedDescription)")
            } catch {
                print("\(thisFunction) error = \(error)")
            }
        }
    }
    // 플래너 modelView 초기 생성 시 사용자 Document의 데이터로 생성
    init() {
        if let url = PlannerChanged.url, let savedModel = try? PlannerModel(url: url) {
            model = savedModel
        } else {
            model = PlannerModel()
        }
    }
}
