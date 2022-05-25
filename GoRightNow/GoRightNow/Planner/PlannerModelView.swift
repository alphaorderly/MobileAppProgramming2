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
    
    func editMode(countryName: String, planName: String, departDate: Date, returnDate: Date, id: String) {
        model.edit(countryName: countryName, planName: planName, departDate: departDate, returnDate: returnDate, id: id)
    }
}
