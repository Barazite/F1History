//
//  ConstructorsServerModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/7/21.
//

import Foundation

// MARK: - ConstructorsServerModel
struct ConstructorsServerModel: Codable {
    let mrData: ConstructorData?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct ConstructorData: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let constructorTable: ConstructorTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case constructorTable = "ConstructorTable"
    }
}

// MARK: - ConstructorTable
struct ConstructorTable: Codable {
    let constructors: [Constructor]?

    enum CodingKeys: String, CodingKey {
        case constructors = "Constructors"
    }
}

// MARK: - Constructor
struct Constructor: Codable {
    let constructorID: String?
    let url: String?
    let name, nationality: String?

    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url, name, nationality
    }
}
