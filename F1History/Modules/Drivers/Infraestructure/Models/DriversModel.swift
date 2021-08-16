//
//  DriversModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import Foundation

struct Drivers: Identifiable, Codable{
    let id: String?
    let url: String?
    let givenName, familyName, dateOfBirth, nationality: String?
    let permanentNumber: String?
    
    init(businessModel: Driver){
        self.id = businessModel.driverID
        self.url = businessModel.url
        self.givenName = businessModel.givenName
        self.familyName = businessModel.familyName
        self.dateOfBirth = businessModel.dateOfBirth
        self.nationality = businessModel.nationality
        self.permanentNumber = businessModel.permanentNumber
    }
}
