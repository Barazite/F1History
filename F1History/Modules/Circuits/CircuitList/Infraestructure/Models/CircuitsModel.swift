//
//  CircuitsModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import Foundation

struct Circuits: Identifiable, Codable {
    let id: String?
    let url: String?
    let circuitName: String?
    let locality, country: String?
    let lat, long: Double?
    
    init(businessModel: Circuit){
        self.id = businessModel.circuitID
        self.url = businessModel.url
        self.circuitName = businessModel.circuitName
        self.lat = (businessModel.location?.lat as! NSString).doubleValue
        self.long = (businessModel.location?.long as! NSString).doubleValue
        self.locality = businessModel.location?.locality
        self.country = businessModel.location?.country
    }
}

