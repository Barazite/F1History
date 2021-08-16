//
//  SchedulesModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

struct SchedulesModel: Identifiable {
    let id = UUID()
    let round: String?
    let raceName: String?
    let circuitName: String?
    let date: String?
    
    
    init(businessModel: Race){
        self.round = businessModel.round
        self.raceName = businessModel.raceName
        self.circuitName = businessModel.circuit?.circuitName
        self.date = businessModel.date
    }
}
