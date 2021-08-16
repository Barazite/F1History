//
//  ConstructorsStandingsModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

struct ConstructorsStandingsModel: Identifiable {
    let id = UUID()
    let position: String?
    let points: String?
    let wins: String?
    let constructor: String?
    
    
    init(businessModel: ConstructorStanding){
        self.position = businessModel.position
        self.points = businessModel.points
        self.wins = businessModel.wins
        self.constructor = businessModel.constructor?.name
    }
}
