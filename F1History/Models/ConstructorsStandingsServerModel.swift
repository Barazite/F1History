//
//  ConstructorsStandingsServerModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

// MARK: - ConstructorsStandingsServerModel
struct ConstructorsStandingsServerModel: Codable {
    let mrData: ConstructorsStandings?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct ConstructorsStandings: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let standingsTable: ConstructorStandingsTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
struct ConstructorStandingsTable: Codable {
    let season: String?
    let standingsLists: [ConstructorStandingsList]?

    enum CodingKeys: String, CodingKey {
        case season
        case standingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList
struct ConstructorStandingsList: Codable {
    let season, round: String?
    let constructorStandings: [ConstructorStanding]?

    enum CodingKeys: String, CodingKey {
        case season, round
        case constructorStandings = "ConstructorStandings"
    }
}

// MARK: - ConstructorStanding
struct ConstructorStanding: Codable {
    let position, positionText, points, wins: String?
    let constructor: Constructor?

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case constructor = "Constructor"
    }
}

