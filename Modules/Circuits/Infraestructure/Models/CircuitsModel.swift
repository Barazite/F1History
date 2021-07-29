//
//  CircuitsModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import Foundation

struct Circuits: Identifiable {
    let id: String?
    let url: String?
    let circuitName: String?
    let lat, long, locality, country: String?
    
    init(businessModel: Circuit){
        self.id = businessModel.circuitID
        self.url = businessModel.url
        self.circuitName = businessModel.circuitName
        self.lat = businessModel.location?.lat
        self.long = businessModel.location?.long
        self.locality = businessModel.location?.locality
        self.country = businessModel.location?.country
    }
}

