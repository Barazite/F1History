//
//  ConstructorsModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/7/21.
//

import Foundation

struct Constructors: Identifiable {
    let id: String?
    let url: String?
    let name, nationality: String?
    
    init(businessModel: Constructor){
        self.id = businessModel.constructorID
        self.url = businessModel.url
        self.name = businessModel.name
        self.nationality = businessModel.nationality
    }

}
