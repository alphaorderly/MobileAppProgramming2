//
//  PlannerModelView.swift
//  GoRightNow
//
//  Created by WOO on 2022/05/16.
//

import Foundation

class PlannerModelView: ObservableObject {
    @Published var model: PlannerModel = PlannerModel()
    
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
}
