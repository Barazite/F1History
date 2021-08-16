//
//  DriverStandingsModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

struct DriverStandingModel: Identifiable {
    let id = UUID()
    let position: String?
    let points: String?
    let wins: String?
    let name: String?
    let constructor: String?
    
    
    init(businessModel: DriverStanding){
        self.position = businessModel.position
        self.points = businessModel.points
        self.wins = businessModel.wins
        self.name = businessModel.driver?.familyName
        self.constructor = businessModel.constructors?.first?.name
    }
}
