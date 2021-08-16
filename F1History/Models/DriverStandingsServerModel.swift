//
//  DriverStandingsServerModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

// MARK: - DriverStandingsServerModel
struct DriverStandingsServerModel: Codable {
    let mrData: DriverStandings?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct DriverStandings: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let standingsTable: DriverStandingsTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
struct DriverStandingsTable: Codable {
    let season: String?
    let standingsLists: [DriverStandingsList]?

    enum CodingKeys: String, CodingKey {
        case season
        case standingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList
struct DriverStandingsList: Codable {
    let season, round: String?
    let driverStandings: [DriverStanding]?

    enum CodingKeys: String, CodingKey {
        case season, round
        case driverStandings = "DriverStandings"
    }
}

// MARK: - DriverStanding
struct DriverStanding: Codable {
    let position, positionText, points, wins: String?
    let driver: Driver?
    let constructors: [Constructor]?

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}



