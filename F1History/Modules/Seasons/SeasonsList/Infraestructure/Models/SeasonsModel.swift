//
//  SeasonsModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 6/7/21.
//

import Foundation

struct Seasons: Identifiable, Codable{
    let id : UUID
    let season: String?
    let url: String?
    
    init(businessModel: Season){
        self.id = UUID()
        self.season = businessModel.season
        self.url = businessModel.url
    }
}
