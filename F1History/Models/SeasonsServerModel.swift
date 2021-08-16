//
//  SeasonsServerModel.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import Foundation

// MARK: - SeasonsServerModel
struct SeasonsServerModel: Codable {
    let mrData: MRData?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct MRData: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let seasonTable: SeasonTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case seasonTable = "SeasonTable"
    }
}

// MARK: - SeasonTable
struct SeasonTable: Codable {
    let seasons: [Season]?

    enum CodingKeys: String, CodingKey {
        case seasons = "Seasons"
    }
}

// MARK: - Season
struct Season: Codable {
    let season: String?
    let url: String?
}
