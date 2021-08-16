//
//  DriversServerModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import Foundation

// MARK: - DriversServerModel
struct DriversServerModel: Codable {
    let mrData: DataDrivers?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct DataDrivers: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let driverTable: DriverTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case driverTable = "DriverTable"
    }
}

// MARK: - DriverTable
struct DriverTable: Codable {
    let drivers: [Driver]?

    enum CodingKeys: String, CodingKey {
        case drivers = "Drivers"
    }
}

// MARK: - Driver
struct Driver: Codable {
    let driverID, code: String?
    let url: String?
    let givenName, familyName, dateOfBirth, nationality: String?
    let permanentNumber: String?

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case code, url, givenName, familyName, dateOfBirth, nationality, permanentNumber
    }
}
