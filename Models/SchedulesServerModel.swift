//
//  SchedulesServerModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

// MARK: - SchedulesServerModel
struct SchedulesServerModel: Codable {
    let mrData: Schedules?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct Schedules: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let raceTable: RaceTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case raceTable = "RaceTable"
    }
}

// MARK: - RaceTable
struct RaceTable: Codable {
    let season: String?
    let races: [Race]?

    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

// MARK: - Race
struct Race: Codable {
    let season, round: String?
    let url: String?
    let raceName: String?
    let circuit: Circuit?
    let date, time: String?

    enum CodingKeys: String, CodingKey {
        case season, round, url, raceName
        case circuit = "Circuit"
        case date, time
    }
}


