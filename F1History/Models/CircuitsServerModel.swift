//
//  CircuitsServerModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import Foundation

// MARK: - CircuitsServerModel
struct CircuitsServerModel: Codable {
    let mrData: CircuitData?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct CircuitData: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let circuitTable: CircuitTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case circuitTable = "CircuitTable"
    }
}

// MARK: - CircuitTable
struct CircuitTable: Codable {
    let circuits: [Circuit]?

    enum CodingKeys: String, CodingKey {
        case circuits = "Circuits"
    }
}

// MARK: - Circuit
struct Circuit: Codable {
    let circuitID: String?
    let url: String?
    let circuitName: String?
    let location: Location?

    enum CodingKeys: String, CodingKey {
        case circuitID = "circuitId"
        case url, circuitName
        case location = "Location"
    }
}

// MARK: - Location
struct Location: Codable {
    let lat, long, locality, country: String?
}
